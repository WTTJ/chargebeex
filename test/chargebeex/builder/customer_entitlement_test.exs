defmodule Chargebeex.Builder.CustomerEntitlementTest do
  use ExUnit.Case, async: true

  alias Chargebeex.Builder
  alias Chargebeex.Fixtures.CustomerEntitlement, as: CustomerEntitlementFixture
  alias Chargebeex.CustomerEntitlement

  describe "build/1" do
    test "should build an customer_entitlement" do
      builded =
        CustomerEntitlementFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()

      assert %{"customer_entitlement" => %CustomerEntitlement{}} = builded
    end

    test "should have the customer_entitlement params" do
      customer_entitlement =
        CustomerEntitlementFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()
        |> Map.get("customer_entitlement")

      params = CustomerEntitlementFixture.customer_entitlement_params() |> Jason.decode!()

      assert customer_entitlement.subscription_id == Map.get(params, "subscription_id")
      assert customer_entitlement.customer_id == Map.get(params, "customer_id")
      assert customer_entitlement.feature_id == Map.get(params, "feature_id")
      assert customer_entitlement.value == Map.get(params, "value")
      assert customer_entitlement.name == Map.get(params, "name")
      assert customer_entitlement.is_enabled == Map.get(params, "is_enabled")
      assert customer_entitlement.object == Map.get(params, "object")
    end
  end
end
