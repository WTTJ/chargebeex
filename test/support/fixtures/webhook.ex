defmodule ChargebeeElixir.Fixtures.Webhook do
  alias ChargebeeElixir.Fixtures.Event, as: FixtureEvent

  def customer_updated(params \\ %{}) do
    FixtureEvent.customer_updated()
    |> Map.get("event")
    |> Map.merge(params)
  end
end
