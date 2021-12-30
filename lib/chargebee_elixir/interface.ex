defmodule ChargebeeElixir.Interface do
  def get(path) do
    get(path, %{})
  end

  def get(path, params) do
    params_string =
      params
      |> URI.encode_query()

    url =
      [fullpath(path), params_string]
      |> Enum.filter(fn s -> String.length(s) > 0 end)
      |> Enum.join("?")

    http_client().get!(url, headers())
    |> handle_response()
  end

  def post(path, data) do
    body =
      data
      |> transform_arrays_for_chargebee
      |> Plug.Conn.Query.encode()

    http_client().post!(
      fullpath(path),
      body,
      headers() ++ [{"Content-Type", "application/x-www-form-urlencoded"}]
    )
    |> handle_response()
  end

  defp handle_response(%{body: body, status_code: 200}) do
    body
    |> Jason.decode!()
  end

  defp handle_response(%{body: body, status_code: 400}) do
    message =
      body
      |> Jason.decode!()
      |> Map.get("message")

    raise ChargebeeElixir.InvalidRequestError, message: message
  end

  defp handle_response(%{status_code: 401}) do
    raise ChargebeeElixir.UnauthorizedError
  end

  defp handle_response(%{status_code: 404}) do
    raise ChargebeeElixir.NotFoundError
  end

  defp handle_response(%{}) do
    raise ChargebeeElixir.UnknownError
  end

  defp http_client() do
    Application.get_env(:chargebee_elixir, :http_client, HTTPoison)
  end

  defp fullpath(path) do
    namespace = Application.get_env(:chargebee_elixir, :namespace)
    "https://#{namespace}.chargebee.com/api/v2#{path}"
  end

  defp headers() do
    api_key = Application.get_env(:chargebee_elixir, :api_key)

    [
      {"Authorization", "Basic #{"#{api_key}:" |> Base.encode64()}"}
    ]
  end

  def transform_arrays_for_chargebee(data) do
    case data do
      map_data when is_map(map_data) ->
        map_data
        |> Enum.map(fn {k, v} ->
          {k, transform_arrays_for_chargebee(v)}
        end)
        |> Enum.into(%{})

      list_data when is_list(list_data) ->
        transformed_list_data =
          list_data
          |> Enum.map(fn item -> transform_arrays_for_chargebee(item) end)

        transformed_list_data
        |> Enum.map(fn item ->
          case item do
            map_item when is_map(map_item) ->
              Map.keys(map_item)

            _ ->
              raise ChargebeeElixir.IncorrectDataFormatError,
                message: "Unsupported data: lists should contains objects only"
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

      other_data ->
        other_data
    end
  end
end
