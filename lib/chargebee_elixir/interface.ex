defmodule ChargebeeElixir.Interface do

  def get(path) do
    get(path, %{})
  end

  def get(path, params) do
    params_string = params
      |> URI.encode_query()

    url = [fullpath(path), params_string]
      |> Enum.filter(fn(s) -> String.length(s) > 0 end)
      |> Enum.join("?")

    http_client().get!(url,headers())
      |> handle_response()
  end

  def post(path, data) do
    body = data
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
      |> Jason.decode!
  end

  defp handle_response(%{body: body, status_code: 400}) do
    message = body
      |> Jason.decode!
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
      {"Authorization", "Basic #{"#{api_key}:" |> Base.encode64}"}
    ]
  end
end
