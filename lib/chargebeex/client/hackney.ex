defmodule Chargebeex.Client.Hackney do
  @moduledoc false
  @behaviour Chargebeex.ClientBehaviour

  def get(url, body, headers \\ []) do
    request(:get, url, body, headers, [:with_body])
  end

  def post(url, body, headers \\ []) do
    request(:post, url, body, headers, [:with_body])
  end

  defp request(verb, url, body, headers, opts) do
    verb
    |> :hackney.request(
      url,
      headers,
      body,
      opts
    )
  end
end
