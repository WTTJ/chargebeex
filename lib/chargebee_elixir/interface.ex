defmodule Chargebeex.Interface do
  def endpoint(path, params \\ %{}) do
    namespace = Application.get_env(:chargebeex, :namespace)
    host = Application.get_env(:chargebeex, :host)
    base_path = Application.get_env(:chargebeex, :path)

    uri = %URI{
      host: "#{namespace}.#{host}",
      path: "#{base_path}#{path}",
      scheme: "https"
    }

    case params do
      params when params == %{} ->
        uri

      params ->
        %{uri | query: URI.encode_query(params)}
    end
    |> URI.to_string()
  end

  def get(path, params \\ %{}) do
    url = endpoint(path, params)

    case apply(http_client(), :get, [url, "", default_headers()]) do
      {:ok, status_code, headers, body} when status_code in 200..299 ->
        {:ok, status_code, headers, Jason.decode!(body)}

      {:ok, status_code, headers, body} ->
        {:error, status_code, headers, Jason.decode!(body)}
    end
  end

  def post(path, data) do
    body =
      data
      |> transform_arrays_for_chargebee
      |> Plug.Conn.Query.encode()

    url = endpoint(path)

    case apply(http_client(), :post, [url, body, default_headers(:post)]) do
      {:ok, status_code, headers, body} when status_code in 200..299 ->
        {:ok, status_code, headers, Jason.decode!(body)}

      {:ok, status_code, headers, body} ->
        {:error, status_code, headers, Jason.decode!(body)}
    end
  end

  defp http_client() do
    Application.get_env(:chargebeex, :http_client, Chargebeex.Client.Hackney)
  end

  defp default_headers(verb \\ :get) do
    []
    |> add_basic_auth(verb)
    |> add_content_type(verb)
  end

  defp add_basic_auth(headers, _verb) do
    api_key = Application.get_env(:chargebeex, :api_key)
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
