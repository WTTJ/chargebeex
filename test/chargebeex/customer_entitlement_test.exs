defmodule Chargebeex.CustomerEntitlementTest do
  use ExUnit.Case, async: true

  import Hammox

  alias Chargebeex.Fixtures.Common
  alias Chargebeex.CustomerEntitlement

  setup :verify_on_exit!

  describe "list" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/customers/customer_id/customer_entitlements"

          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = CustomerEntitlement.list("customer_id")
    end

    test "with no param, no offset should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/customers/customer_id/customer_entitlements"

          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 200, [],
           Jason.encode!(%{
             list: [%{customer_entitlement: %{}}, %{customer_entitlement: %{}}]
           })}
        end
      )

      assert {:ok, [%CustomerEntitlement{}, %CustomerEntitlement{}], %{"next_offset" => nil}} =
               CustomerEntitlement.list("customer_id")
    end

    test "with limit & offset params should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/customers/customer_id/customer_entitlements?limit=1&feature_type%5Bis%5D=switch"

          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          result = %{
            list: [%{customer_entitlement: %{customer_id: "customer_id"}}],
            next_offset: "bar"
          }

          {:ok, 200, [], Jason.encode!(result)}
        end
      )

      assert {:ok, [%CustomerEntitlement{}], %{"next_offset" => "bar"}} =
               CustomerEntitlement.list("customer_id", %{
                 "feature_type[is]" => "switch",
                 limit: 1
               })
    end
  end
end
