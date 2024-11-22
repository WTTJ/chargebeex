defmodule Chargebeex.SubscriptionEntitlementTest do
  use ExUnit.Case, async: true

  import Hammox

  alias Chargebeex.Fixtures.Common
  alias Chargebeex.SubscriptionEntitlement

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
end
