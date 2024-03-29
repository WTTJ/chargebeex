defmodule Chargebeex.Builder.SubscriptionTest do
  use ExUnit.Case, async: true

  alias Chargebeex.Builder
  alias Chargebeex.Fixtures.Subscription, as: SubscriptionFixture
  alias Chargebeex.{Customer, Subscription}

  describe "build/1" do
    test "should build a subscription" do
      builded =
        SubscriptionFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()

      assert %{"subscription" => %Subscription{}, "customer" => %Customer{}} = builded
    end

    test "should build a list of subscription" do
      builded =
        SubscriptionFixture.list()
        |> Jason.decode!()
        |> Builder.build()

      assert {[
                %{"subscription" => %Subscription{}, "customer" => %Customer{}},
                %{"subscription" => %Subscription{}, "customer" => %Customer{}}
              ], %{"next_offset" => _}} = builded
    end

    test "should have subscription params" do
      subscription =
        SubscriptionFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()
        |> Map.get("subscription")

      params = SubscriptionFixture.subscription_params() |> Jason.decode!()

      assert subscription.activated_at == Map.get(params, "activated_at")
      assert subscription.billing_period == Map.get(params, "billing_period")
      assert subscription.billing_period_unit == Map.get(params, "billing_period_unit")
      assert subscription.created_at == Map.get(params, "created_at")
      assert subscription.currency_code == Map.get(params, "currency_code")
      assert subscription.current_term_end == Map.get(params, "current_term_end")
      assert subscription.current_term_start == Map.get(params, "current_term_start")
      assert subscription.customer_id == Map.get(params, "customer_id")
      assert subscription.deleted == Map.get(params, "deleted")
      assert subscription.due_invoices_count == Map.get(params, "due_invoices_count")
      assert subscription.due_since == Map.get(params, "due_since")
      assert subscription.has_scheduled_changes == Map.get(params, "has_scheduled_changes")
      assert subscription.id == Map.get(params, "id")
      assert subscription.mrr == Map.get(params, "mrr")
      assert subscription.next_billing_at == Map.get(params, "next_billing_at")
      assert subscription.object == Map.get(params, "object")
      assert subscription.remaining_billing_cycles == Map.get(params, "remaining_billing_cycles")
      assert subscription.resource_version == Map.get(params, "resource_version")
      assert subscription.started_at == Map.get(params, "started_at")
      assert subscription.status == Map.get(params, "status")
      assert subscription.subscription_items == Map.get(params, "subscription_items")
      assert subscription.total_dues == Map.get(params, "total_dues")
      assert subscription.updated_at == Map.get(params, "updated_at")
    end

    test "should handle custom fields" do
      subscription =
        SubscriptionFixture.retrieve()
        |> Jason.decode!()
        |> Map.get("subscription")
        |> Map.merge(%{
          "cf_foo" => "baz",
          "cf_bar" => "baz"
        })

      assert %Subscription{
               custom_fields: %{
                 "cf_foo" => "baz",
                 "cf_bar" => "baz"
               }
             } =
               %{"subscription" => subscription}
               |> Builder.build()
               |> Map.get("subscription")
    end
  end
end
