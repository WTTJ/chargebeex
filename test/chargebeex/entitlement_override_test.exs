defmodule Chargebeex.EntitlementOverrideTest do
  use ExUnit.Case, async: true

  import Hammox

  alias Chargebeex.Fixtures.Common
  alias Chargebeex.EntitlementOverride
  alias Chargebeex.Fixtures.EntitlementOverride, as: EntitlementOverrideFixture

  setup :verify_on_exit!

  describe "upsert_or_remove" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/subscriptions/subscription_id/entitlement_overrides"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert body == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} =
               EntitlementOverride.upsert_or_remove("subscription_id", %{})
    end

    test "with valid data should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/subscriptions/subscription_id/entitlement_overrides"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert data ==
                   "action=upsert&entitlement_overrides[feature_id][0]=override-1935f8d6-b791-4181-9fa2-65fd8bfbd7ae&entitlement_overrides[value][0]=true"

          {:ok, 200, [], EntitlementOverrideFixture.list()}
        end
      )

      subscription_id = "subscription_id"

      params = %{
        "action" => :upsert,
        "entitlement_overrides" => [
          %{
            "feature_id" => "override-1935f8d6-b791-4181-9fa2-65fd8bfbd7ae",
            "value" => "true"
          }
        ]
      }

      assert {:ok, [%EntitlementOverride{}], %{"next_offset" => nil}} =
               Chargebeex.EntitlementOverride.upsert_or_remove(subscription_id, params)
    end

    test "raises an error when action is invalid" do
      subscription_id = "sub_123"
      invalid_params = %{"action" => :invalid_action}
      opts = []

      assert_raise ArgumentError, ~r/Invalid action provided to `upsert_or_remove`/, fn ->
        EntitlementOverride.upsert_or_remove(subscription_id, invalid_params, opts)
      end
    end
  end
end
