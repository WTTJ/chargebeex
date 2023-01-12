defmodule Chargebeex.Builder.TimeMachineTest do
  use ExUnit.Case, async: true

  alias Chargebeex.Builder
  alias Chargebeex.Fixtures.TimeMachine, as: TimeMachineFixture
  alias Chargebeex.TimeMachine

  describe "build/1" do
    test "should build an time machine" do
      builded =
        TimeMachineFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()

      assert %{"time_machine" => %TimeMachine{}} = builded
    end

    test "should have time machine params" do
      time_machine =
        TimeMachineFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()
        |> Map.get("time_machine")

      params = TimeMachineFixture.time_machine_params() |> Jason.decode!()

      assert time_machine.destination_time == Map.get(params, "destination_time")
      assert time_machine.genesis_time == Map.get(params, "genesis_time")
      assert time_machine.name == Map.get(params, "name")
      assert time_machine.object == Map.get(params, "object")
      assert time_machine.time_travel_status == Map.get(params, "time_travel_status")
    end
  end
end
