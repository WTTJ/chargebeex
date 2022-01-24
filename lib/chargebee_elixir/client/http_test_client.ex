defmodule Chargebeex.Client.HTTPTestClient do
  @behaviour Chargebeex.ClientBehaviour

  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get(url, body, _headers) do
    store(url, :get, body)

    {:ok, 200, [], "{}"}
  end

  def post(url, body, _headers) do
    store(url, :post, body)

    {:ok, 200, [], "{}"}
  end

  def storage_key(url, verb), do: Enum.join([verb, url], "|")

  def store(url, verb, body) do
    Agent.update(__MODULE__, fn state ->
      key = storage_key(url, verb)

      state
      |> Map.put(key, Map.get(state, key, []) ++ List.wrap(%{body: body}))
    end)
  end

  def assert_called(url, verb, expected_body) do
    Agent.get(__MODULE__, fn state ->
      case Map.get(state, storage_key(url, verb)) do
        nil ->
          false

        v ->
          found =
            Enum.find(v, fn %{body: body} ->
              body = URI.decode_query(body)
              Enum.all?(expected_body, &Enum.member?(body, &1))
            end)

          not is_nil(found)
      end
    end)
  end
end
