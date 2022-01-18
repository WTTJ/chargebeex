defmodule Chargebeex.Client.HTTPTestClient do
  @behaviour Chargebeex.ClientBehaviour

  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{post: [], get: []} end, name: __MODULE__)
  end

  def get(url, body, headers \\ []) do
    store(:get, {url, body, headers})

    {:ok, 200, [], "{}"}
  end

  def post(url, body, headers \\ []) do
    store(:post, {url, body, headers})

    {:ok, 200, [], "{}"}
  end

  def store(verb, content) do
    Agent.update(__MODULE__, fn state ->
      %{state | verb => Map.get(state, verb, []) ++ [content]}
    end)
  end
end
