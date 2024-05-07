defmodule Chargebeex.SubscriptionTest do
  use ExUnit.Case, async: true

  import Hammox

  alias Chargebeex.Fixtures.Common
  alias Chargebeex.Subscription

  setup :verify_on_exit!

  describe "create_with_items" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/customers/foobar/subscription_for_items"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert data == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} =
               Chargebeex.Subscription.create_with_items("foobar", %{})
    end

    test "with invalid data should fail" do
      bad_request = Common.bad_request()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/customers/foobar/subscription_for_items"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert data ==
                   "subscription_items[quantity][0]=1&subscription_items[item_price_id][0]=invalid_item_price_id"

          {:ok, 400, [], Jason.encode!(bad_request)}
        end
      )

      assert {:error, 400, [], ^bad_request} =
               Chargebeex.Subscription.create_with_items("foobar", %{
                 subscription_items: [
                   %{
                     item_price_id: "invalid_item_price_id",
                     quantity: 1
                   }
                 ]
               })
    end

    test "with valid data should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/customers/foobar/subscription_for_items"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert data ==
                   "subscription_items[quantity][0]=1&subscription_items[item_price_id][0]=item_price_id"

          {:ok, 200, [], Jason.encode!(%{customer: %{}, subscription: %{}})}
        end
      )

      assert {:ok, %Subscription{}} =
               Chargebeex.Subscription.create_with_items("foobar", %{
                 subscription_items: [
                   %{
                     item_price_id: "item_price_id",
                     quantity: 1
                   }
                 ]
               })
    end
  end

  describe "update_for_items" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/subscriptions/foobar/update_for_items"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert data == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} =
               Chargebeex.Subscription.update_for_items("foobar", %{})
    end

    test "with invalid data should fail" do
      bad_request = Common.bad_request()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/subscriptions/foobar/update_for_items"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert data ==
                   "subscription_items[quantity][0]=1&subscription_items[item_price_id][0]=invalid_item_price_id"

          {:ok, 400, [], Jason.encode!(bad_request)}
        end
      )

      assert {:error, 400, [], ^bad_request} =
               Chargebeex.Subscription.update_for_items("foobar", %{
                 subscription_items: [
                   %{
                     item_price_id: "invalid_item_price_id",
                     quantity: 1
                   }
                 ]
               })
    end

    test "with valid data should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/subscriptions/foobar/update_for_items"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert data ==
                   "subscription_items[quantity][0]=1&subscription_items[item_price_id][0]=item_price_id"

          {:ok, 200, [], Jason.encode!(%{customer: %{}, subscription: %{}})}
        end
      )

      assert {:ok, %Subscription{}} =
               Chargebeex.Subscription.update_for_items("foobar", %{
                 subscription_items: [
                   %{
                     item_price_id: "item_price_id",
                     quantity: 1
                   }
                 ]
               })
    end
  end
end
