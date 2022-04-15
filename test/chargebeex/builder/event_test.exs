defmodule Chargebeex.Builder.EventTest do
  use ExUnit.Case, async: true

  alias Chargebeex.Builder
  alias Chargebeex.Customer
  alias Chargebeex.Fixtures.Event, as: EventFixture
  alias Chargebeex.Event

  describe "build/1" do
    test "should build an event" do
      builded =
        EventFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()

      assert %{"event" => %Event{}} = builded
    end

    test "should build a list of events" do
      builded =
        EventFixture.list()
        |> Jason.decode!()
        |> Builder.build()

      assert {[
                %{"event" => %Event{}},
                %{"event" => %Event{}}
              ], %{"next_offset" => _}} = builded
    end

    test "should have event params" do
      event =
        EventFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()
        |> Map.get("event")

      params = EventFixture.event_params() |> Jason.decode!()

      assert event.api_version == Map.get(params, "api_version")
      assert event.event_type == Map.get(params, "event_type")
      assert event.id == Map.get(params, "id")
      assert event.object == Map.get(params, "object")
      assert event.occurred_at == Map.get(params, "occurred_at")
      assert event.source == Map.get(params, "source")
      assert event.user == Map.get(params, "user")
      assert event.webhook_status == Map.get(params, "webhook_status")

      assert %Customer{} = event.content["customer"]
    end
  end
end
