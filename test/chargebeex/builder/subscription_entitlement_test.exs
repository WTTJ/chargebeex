defmodule Chargebeex.Builder.SubscriptionEntitlementTest do
  use ExUnit.Case, async: true

  alias Chargebeex.Builder
  alias Chargebeex.Fixtures.SubscriptionEntitlement, as: SubscriptionEntitlementFixture
  alias Chargebeex.SubscriptionEntitlement

  describe "build/1" do
    test "should build an subscription_entitlement" do
      builded =
        SubscriptionEntitlementFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()

      assert %{"subscription_entitlement" => %SubscriptionEntitlement{}} = builded
    end

    test "should have the subscription_entitlement params" do
      subscription_entitlement =
        SubscriptionEntitlementFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()
        |> Map.get("subscription_entitlement")

      params = SubscriptionEntitlementFixture.subscription_entitlement_params() |> Jason.decode!()

      assert subscription_entitlement.subscription_id == Map.get(params, "subscription_id")
      assert subscription_entitlement.feature_id == Map.get(params, "feature_id")
      assert subscription_entitlement.feature_name == Map.get(params, "feature_name")
      assert subscription_entitlement.feature_type == Map.get(params, "feature_type")
      assert subscription_entitlement.value == Map.get(params, "value")
      assert subscription_entitlement.name == Map.get(params, "name")
      assert subscription_entitlement.is_overridden == Map.get(params, "is_overridden")
      assert subscription_entitlement.is_enabled == Map.get(params, "is_enabled")
      assert subscription_entitlement.object == Map.get(params, "object")
    end
  end
end
