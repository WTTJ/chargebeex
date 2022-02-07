defmodule Chargebeex.SubscriptionTest do
  use ExUnit.Case, async: true

  import Mox

  alias Chargebeex.Fixtures.Common
  alias Chargebeex.Fixtures.Subscription, as: SusbscriptionFixture
  alias Chargebeex.Subscription

  setup :verify_on_exit!

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

          {:ok, 200, [], SusbscriptionFixture.list()}
        end
      )

      assert {:ok,
              [
                %{
                  "subscription" => %Chargebeex.Subscription{},
                  "customer" => %Chargebeex.Customer{}
                }
              ], _} = Subscription.list()
    end

    test "should have subscription values parsed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/subscriptions"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 200, [], SusbscriptionFixture.list()}
        end
      )

      assert {:ok, [%Chargebeex.Subscription{} = subscription], %{"next_offset" => next_offset}} =
               Subscription.list()

      assert next_offset == "1612890918000"
      assert subscription.activated_at == 1_612_890_920
      assert subscription.billing_period == 1
      assert subscription.billing_period_unit == "month"
      assert subscription.created_at == 1_612_890_920
      assert subscription.currency_code == "USD"
      assert subscription.current_term_end == 1_615_310_120
      assert subscription.current_term_start == 1_612_890_920
      assert subscription.customer_id == "__test__8asukSOXdvg4PD"
      assert subscription.deleted == false
      assert subscription.due_invoices_count == 1
      assert subscription.due_since == 1_612_890_920
      assert subscription.has_scheduled_changes == false
      assert subscription.id == "__test__8asukSOXdvliPG"
      assert subscription.mrr == 0
      assert subscription.next_billing_at == 1_615_310_120
      assert subscription.object == "subscription"
      assert subscription.remaining_billing_cycles == 1
      assert subscription.resource_version == 1_612_890_920_000
      assert subscription.started_at == 1_612_890_920
      assert subscription.status == "active"

      assert subscription.subscription_items == [
               %{
                 "amount" => 1000,
                 "billing_cycles" => 1,
                 "free_quantity" => 0,
                 "item_price_id" => "basic-USD",
                 "item_type" => "plan",
                 "object" => "subscription_item",
                 "quantity" => 1,
                 "unit_price" => 1000
               }
             ]

      assert subscription.total_dues == 1100
      assert subscription.updated_at == 1_612_890_920
    end
  end
end
