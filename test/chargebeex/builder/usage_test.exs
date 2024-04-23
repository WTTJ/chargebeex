defmodule Chargebeex.Builder.UsageTest do
  use ExUnit.Case, async: true

  alias Chargebeex.Builder
  alias Chargebeex.Fixtures.Usage, as: UsageFixture
  alias Chargebeex.Usage

  describe "build/1" do
    test "should build an usage" do
      builded =
        UsageFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()

      assert %{"usage" => %Usage{}} = builded
    end

    test "should have the usage params" do
      usage =
        UsageFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()
        |> Map.get("usage")

      params = UsageFixture.usage_params() |> Jason.decode!()

      assert usage.id == Map.get(params, "id")
      assert usage.updated_at == Map.get(params, "updated_at")
      assert usage.usage_date == Map.get(params, "usage_date")
      assert usage.subscription_id == Map.get(params, "subscription_id")
      assert usage.item_price_id == Map.get(params, "item_price_id")
      assert usage.invoice_id == Map.get(params, "invoice_id")
      assert usage.line_item_id == Map.get(params, "line_item_id")
      assert usage.quantity == Map.get(params, "quantity")
      assert usage.source == Map.get(params, "source")
      assert usage.resource_version == Map.get(params, "resource_version")
      assert usage.created_at == Map.get(params, "created_at")
    end
  end
end
