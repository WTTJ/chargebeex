defmodule Chargebeex.Fixtures.Webhook do
  alias Chargebeex.Fixtures.Event, as: FixtureEvent

  def customer_updated(params \\ %{}) do
    FixtureEvent.customer_updated()
    |> Map.get("event")
    |> Map.merge(params)
  end
end
