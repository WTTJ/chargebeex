defmodule Chargebeex.Builder.EntitlementOverrideTest do
  use ExUnit.Case, async: true

  alias Chargebeex.Builder
  alias Chargebeex.Fixtures.EntitlementOverride, as: EntitlementOverrideFixture
  alias Chargebeex.EntitlementOverride

  describe "build/1" do
    test "should build an entitlement override" do
      builded =
        EntitlementOverrideFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()

      assert %{"entitlement_override" => %EntitlementOverride{}} = builded
    end

    test "should have the entitlement_override params" do
      entitlement_override =
        EntitlementOverrideFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()
        |> Map.get("entitlement_override")

      params = EntitlementOverrideFixture.entitlement_override_params() |> Jason.decode!()

      assert entitlement_override.entity_id == Map.get(params, "entity_id")
      assert entitlement_override.entity_type == Map.get(params, "entity_type")
      assert entitlement_override.feature_id == Map.get(params, "feature_id")
      assert entitlement_override.feature_name == Map.get(params, "feature_name")
      assert entitlement_override.id == Map.get(params, "id")
      assert entitlement_override.name == Map.get(params, "name")
      assert entitlement_override.object == Map.get(params, "object")
      assert entitlement_override.value == Map.get(params, "value")
    end
  end
end
