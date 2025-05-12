defmodule Chargebeex.Client do
  @moduledoc false

  defp config(:default, path) do
    Application.get_env(:chargebeex, path)
  end

  defp config(site, path) do
    default = Application.get_env(:chargebeex, path)

    if site in [:host, :path, :namespace, :api_key] do
      raise ArgumentError, "Site `#{inspect(site)}` is not permitted"
    end

    case Application.get_env(:chargebeex, site) do
      nil ->
        raise ArgumentError, "Site `#{inspect(site)}` is not configured"

      config ->
        # Falls back to default config if the site config does not have the
        # specified key. i.e. `:host` or `:path` is not configured
        Keyword.get(config, path, default)
    end
  end

  def endpoint(site, path, params \\ %{}) do
    namespace = config(site, :namespace)
    host = config(site, :host)
    base_path = config(site, :path)

    uri = %URI{
      host: "#{namespace}.#{host}",
      path: "#{base_path}#{path}",
      scheme: "https"
    }

    case params do
      params when params == %{} ->
        uri

      params ->
        %{uri | query: Plug.Conn.Query.encode(params)}
    end
    |> URI.to_string()
  end

  def get(path, params \\ %{}, opts \\ []) do
    site = Keyword.get(opts, :site, :default)
    url = endpoint(site, path, params)

    :telemetry.span([:chargebeex, :request], %{method: :get, url: url, params: params}, fn ->
      {status, status_code, _, _} =
        result =
        case apply(http_client(), :get, [url, "", default_headers(site, opts)]) do
          {:ok, status_code, headers, body} when status_code in 200..299 ->
            {:ok, status_code, headers, get_body_from_response(body)}

          {:ok, status_code, headers, body} ->
            {:error, status_code, headers, get_body_from_response(body)}
        end

      {result, %{status: status, status_code: status_code}}
    end)
  end

  def post(path, params \\ %{}, opts \\ []) do
    site = Keyword.get(opts, :site, :default)
    url = endpoint(site, path)

    body =
      params
      |> transform_arrays_for_chargebee
      |> Plug.Conn.Query.encode()

    :telemetry.span([:chargebeex, :request], %{method: :post, url: url, params: params}, fn ->
      {status, status_code, _, _} =
        result =
        case apply(http_client(), :post, [url, body, default_headers(site, opts, :post)]) do
          {:ok, status_code, headers, body} when status_code in 200..299 ->
            {:ok, status_code, headers, get_body_from_response(body)}

          {:ok, status_code, headers, body} ->
            {:error, status_code, headers, get_body_from_response(body)}
        end

      {result, %{status: status, status_code: status_code}}
    end)
  end

  defp get_body_from_response(body) do
    case Jason.decode(body) do
      {:ok, parsed_body} -> parsed_body
      {:error, _} -> body
    end
  end

  defp http_client() do
    Application.get_env(:chargebeex, :http_client, Chargebeex.Client.Hackney)
  end

  defp default_headers(site, opts, verb \\ :get) do
    []
    |> add_user_details(opts)
    |> add_basic_auth(site)
    |> add_content_type(verb)
  end

  defp add_user_details(headers, opts) do
    ip = Keyword.get(opts, :user_ip)
    device = Keyword.get(opts, :user_device)
    user = Keyword.get(opts, :user_email)
    user_encoded = Keyword.get(opts, :user_email_encoded)

    user_details_headers = [
      {"chargebee-request-origin-ip", ip},
      {"chargebee-request-origin-device", device},
      {"chargebee-request-origin-user-encoded", user_encoded},
      {"chargebee-request-origin-user", user}
    ]

    headers ++ Enum.reject(user_details_headers, fn {_, value} -> is_nil(value) end)
  end

  defp add_basic_auth(headers, site) do
    api_key = config(site, :api_key)
    headers ++ [{"Authorization", "Basic #{"#{api_key}:" |> Base.encode64()}"}]
  end

  defp add_content_type(headers, :post) do
    headers ++ [{"Content-Type", "application/x-www-form-urlencoded"}]
  end

  defp add_content_type(headers, _verb), do: headers

  def transform_arrays_for_chargebee(data) when is_map(data) do
    data
    |> Enum.map(fn {k, v} ->
      {k, transform_arrays_for_chargebee(v)}
    end)
    |> Enum.into(%{})
  end

  def transform_arrays_for_chargebee(data) when is_list(data) do
    transformed_list_data =
      data
      |> Enum.map(&transform_arrays_for_chargebee/1)

    transformed_list_data
    |> Enum.map(fn item ->
      case item do
        map_item when is_map(map_item) ->
          Map.keys(map_item)

        _ ->
          raise "Unsupported data: lists should contains objects only"
      end
    end)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.map(fn key ->
      {
        key,
        transformed_list_data
        |> Enum.with_index()
        |> Enum.map(fn {item, index} -> {index, item[key]} end)
        |> Enum.filter(fn {_index, item} -> !is_nil(item) end)
        |> Enum.into(%{})
      }
    end)
    |> Enum.into(%{})
  end

  def transform_arrays_for_chargebee(data), do: data
end
