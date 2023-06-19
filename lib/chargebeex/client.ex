defmodule Chargebeex.Client do
  @moduledoc false

  defp config(site, path) do
    default = Application.get_env(:chargebeex, path)

    case site do
      :default ->
        default

      site ->
        :chargebeex
        |> Application.get_env(site)
        |> Keyword.get(path, default)
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

    case apply(http_client(), :get, [url, "", default_headers(site)]) do
      {:ok, status_code, headers, body} when status_code in 200..299 ->
        {:ok, status_code, headers, get_body_from_response(body)}

      {:ok, status_code, headers, body} ->
        {:error, status_code, headers, get_body_from_response(body)}
    end
  end

  def post(path, params \\ %{}, opts \\ []) do
    site = Keyword.get(opts, :site, :default)

    body =
      params
      |> transform_arrays_for_chargebee
      |> Plug.Conn.Query.encode()

    url = endpoint(site, path)

    case apply(http_client(), :post, [url, body, default_headers(site, :post)]) do
      {:ok, status_code, headers, body} when status_code in 200..299 ->
        {:ok, status_code, headers, get_body_from_response(body)}

      {:ok, status_code, headers, body} ->
        {:error, status_code, headers, get_body_from_response(body)}
    end
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

  defp default_headers(site, verb \\ :get) do
    []
    |> add_basic_auth(site)
    |> add_content_type(verb)
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
