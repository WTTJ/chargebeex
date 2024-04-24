defmodule Chargebeex.HostedPageTest do
  use ExUnit.Case, async: true

  import Hammox

  alias Chargebeex.Fixtures.Common

  alias Chargebeex.HostedPage

  setup :verify_on_exit!

  describe "retrieve" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/hosted_pages/1234"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = HostedPage.retrieve(1234)
    end

    test "with resource not found should fail" do
      not_found = Common.not_found()

      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/hosted_pages/1234"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 404, [], Jason.encode!(not_found)}
        end
      )

      assert {:error, 404, [], ^not_found} = HostedPage.retrieve(1234)
    end

    test "with resource found should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/hosted_pages/1234"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 200, [], Jason.encode!(%{hosted_page: %{}})}
        end
      )

      assert {:ok, %HostedPage{}} = HostedPage.retrieve(1234)
    end
  end

  describe "list" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/hosted_pages"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = HostedPage.list()
    end

    test "with no param, no offset should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/hosted_pages"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 200, [],
           Jason.encode!(%{
             list: [%{hosted_page: %{}}, %{hosted_page: %{}}]
           })}
        end
      )

      assert {:ok, [%HostedPage{}, %HostedPage{}], %{"next_offset" => nil}} = HostedPage.list()
    end

    test "with limit & offset params should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/hosted_pages?limit=1"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          result = %{
            list: [%{hosted_page: %{}}],
            next_offset: "foobar"
          }

          {:ok, 200, [], Jason.encode!(result)}
        end
      )

      assert {:ok, [%HostedPage{}], %{"next_offset" => "foobar"}} = HostedPage.list(%{limit: 1})
    end
  end

  describe "collect_now" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/hosted_pages/collect_now"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert body == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = HostedPage.collect_now(%{})
    end

    test "with no param, no offset should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/hosted_pages/collect_now"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert body == ""

          {:ok, 200, [], Jason.encode!(%{hosted_page: %{}})}
        end
      )

      assert {:ok, %HostedPage{}} = HostedPage.collect_now(%{})
    end
  end

  describe "checkout_existing_for_items" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/hosted_pages/checkout_existing_for_items"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert body == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = HostedPage.checkout_existing_for_items(%{})
    end

    test "with no param, no offset should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/hosted_pages/checkout_existing_for_items"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert body == ""

          {:ok, 200, [], Jason.encode!(%{hosted_page: %{}})}
        end
      )

      assert {:ok, %HostedPage{}} = HostedPage.checkout_existing_for_items(%{})
    end

    test "with param, without offset should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/hosted_pages/checkout_existing_for_items"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          expected_body =
            MapSet.new([
              "layout=in_app",
              "subscription[id]=subscription_id",
              "subscription_items[item_price_id][0]=item_price_id",
              "subscription_items[quantity][0]=1"
            ])

          assert MapSet.equal?(
                   String.split(body, "&") |> MapSet.new(),
                   expected_body
                 )

          {:ok, 200, [], Jason.encode!(%{hosted_page: %{}})}
        end
      )

      params = %{
        subscription: %{id: "subscription_id"},
        layout: "in_app",
        subscription_items: [
          %{item_price_id: "item_price_id", quantity: 1}
        ]
      }

      assert {:ok, %HostedPage{}} = HostedPage.checkout_existing_for_items(params)
    end
  end
end
