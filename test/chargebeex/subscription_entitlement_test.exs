defmodule Chargebeex.SubscriptionEntitlementTest do
  use ExUnit.Case, async: true

  import Hammox

  alias Chargebeex.Fixtures.Common
  alias Chargebeex.SubscriptionEntitlement
  alias Chargebeex.Fixtures.SubscriptionEntitlement, as: SubscriptionEntitlementFixture

  setup :verify_on_exit!

  describe "list" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/subscriptions/subscription_id/subscription_entitlements"

          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = SubscriptionEntitlement.list("subscription_id")
    end

    test "with no param, no offset should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/subscriptions/subscription_id/subscription_entitlements"

          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 200, [],
           Jason.encode!(%{
             list: [%{subscription_entitlement: %{}}, %{subscription_entitlement: %{}}]
           })}
        end
      )

      assert {:ok, [%SubscriptionEntitlement{}, %SubscriptionEntitlement{}],
              %{"next_offset" => nil}} =
               SubscriptionEntitlement.list("subscription_id")
    end

    test "with limit & offset params should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/subscriptions/subscription_id/subscription_entitlements?limit=1&feature_type%5Bis%5D=switch"

          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          result = %{
            list: [%{subscription_entitlement: %{subscription_id: "subscription_id"}}],
            next_offset: "bar"
          }

          {:ok, 200, [], Jason.encode!(result)}
        end
      )

      assert {:ok, [%SubscriptionEntitlement{}], %{"next_offset" => "bar"}} =
               SubscriptionEntitlement.list("subscription_id", %{
                 "feature_type[is]" => "switch",
                 limit: 1
               })
    end
  end

  describe "set_availability/3" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/subscriptions/subscription_id/subscription_entitlements/set_availability"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert body == "is_enabled=true"

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      params = %{
        "is_enabled" => true,
        "subscription_entitlements" => []
      }

      assert {:error, 401, [], ^unauthorized} =
               SubscriptionEntitlement.set_availability("subscription_id", params)
    end

    test "with valid data should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/subscriptions/subscription_id/subscription_entitlements/set_availability"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert body == "is_enabled=true&subscription_entitlements[feature_id][0]=foo_feature_id"

          {:ok, 200, [], SubscriptionEntitlementFixture.list()}
        end
      )

      subscription_id = "subscription_id"

      params = %{
        "is_enabled" => true,
        "subscription_entitlements" => [
          %{
            "feature_id" => "foo_feature_id"
          }
        ]
      }

      assert {:ok, [%SubscriptionEntitlement{}], %{"next_offset" => _}} =
               SubscriptionEntitlement.set_availability(subscription_id, params)
    end

    test "with invalid params should raise error" do
      subscription_id = "subscription_id"

      invalid_params = %{}

      assert_raise ArgumentError, ~r/Invalid params provided to `set_availability`/, fn ->
        SubscriptionEntitlement.set_availability(subscription_id, invalid_params)
      end
    end
  end
end
