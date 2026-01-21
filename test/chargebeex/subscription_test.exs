defmodule Chargebeex.SubscriptionTest do
  use ExUnit.Case, async: true

  import Hammox

  alias Chargebeex.Fixtures.Common
  alias Chargebeex.Subscription

  setup :verify_on_exit!

  describe "retrieve" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/subscriptions/foobar"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = Subscription.retrieve("foobar")
    end

    test "with resource not found should fail" do
      not_found = Common.not_found()

      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/subscriptions/foobar"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 404, [], Jason.encode!(not_found)}
        end
      )

      assert {:error, 404, [], ^not_found} = Subscription.retrieve("foobar")
    end

    test "with resource found should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/subscriptions/foobar"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 200, [], Jason.encode!(%{subscription: %{}})}
        end
      )

      assert {:ok, %Subscription{}} == Subscription.retrieve("foobar")
    end
  end

  describe "list" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/subscriptions"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = Subscription.list()
    end

    test "with no param, no offset should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/subscriptions"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 200, [], Jason.encode!(%{list: [%{subscription: %{}}, %{subscription: %{}}]})}
        end
      )

      assert {:ok, [%Subscription{}, %Subscription{}], %{"next_offset" => nil}} =
               Subscription.list()
    end

    test "with limit & offset params should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/subscriptions?limit=1"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          result = %{
            list: [%{subscription: %{id: "foo"}}],
            next_offset: "bar"
          }

          {:ok, 200, [], Jason.encode!(result)}
        end
      )

      assert {:ok, [%Subscription{}], %{"next_offset" => "bar"}} = Subscription.list(%{limit: 1})
    end
  end

  describe "update" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, data, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/subscriptions/foobar"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert data == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = Subscription.update("foobar", %{})
    end

    test "with invalid data should fail" do
      bad_request = Common.bad_request()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, data, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/subscriptions/foobar"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert data == "cancel_reason=baz"

          {:ok, 400, [], Jason.encode!(bad_request)}
        end
      )

      assert {:error, 400, [], ^bad_request} =
               Subscription.update("foobar", %{cancel_reason: "baz"})
    end

    test "with valid data should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, data, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/subscriptions/foobar"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert data == "cancel_reason=baz"

          {:ok, 200, [], Jason.encode!(%{subscription: %{}})}
        end
      )

      assert {:ok, %Subscription{}} = Subscription.update("foobar", %{cancel_reason: "baz"})
    end
  end

  describe "delete" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/subscriptions/foobar/delete"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert body == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = Subscription.delete("foobar")
    end

    test "with resource not found should fail" do
      not_found = Common.not_found()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/subscriptions/foobar/delete"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert body == ""

          {:ok, 404, [], Jason.encode!(not_found)}
        end
      )

      assert {:error, 404, [], ^not_found} = Subscription.delete("foobar")
    end

    test "with resource found should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/subscriptions/foobar/delete"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert body == ""

          {:ok, 200, [], Jason.encode!(%{subscription: %{}})}
        end
      )

      assert {:ok, %Subscription{}} == Subscription.delete("foobar")
    end
  end

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

          data = String.split(data, "&")

          assert Enum.count(data) == 2
          assert "subscription_items[quantity][0]=1" in data
          assert "subscription_items[item_price_id][0]=invalid_item_price_id" in data

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

          data = String.split(data, "&")

          assert Enum.count(data) == 2
          assert "subscription_items[quantity][0]=1" in data
          assert "subscription_items[item_price_id][0]=item_price_id" in data

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

          data = String.split(data, "&")

          assert Enum.count(data) == 2
          assert "subscription_items[quantity][0]=1" in data
          assert "subscription_items[item_price_id][0]=invalid_item_price_id" in data

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

          data = String.split(data, "&")

          assert Enum.count(data) == 2
          assert "subscription_items[quantity][0]=1" in data
          assert "subscription_items[item_price_id][0]=item_price_id" in data

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
