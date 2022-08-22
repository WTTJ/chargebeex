defmodule Chargebeex.Builder.ItemPriceTest do
  use ExUnit.Case, async: true

  alias Chargebeex.Builder
  alias Chargebeex.Fixtures.ItemPrice, as: ItemPriceFixture
  alias Chargebeex.ItemPrice

  describe "build/1" do
    test "should build an item_price" do
      builded =
        ItemPriceFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()

      assert %{"item_price" => %ItemPrice{}} = builded
    end

    test "should have the item_price params" do
      item_price =
        ItemPriceFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()
        |> Map.get("item_price")

      params = ItemPriceFixture.item_price_params() |> Jason.decode!()

      assert item_price.created_at == Map.get(params, "created_at")
      assert item_price.currency_code == Map.get(params, "currency_code")
      assert item_price.external_name == Map.get(params, "external_name")
      assert item_price.free_quantity == Map.get(params, "free_quantity")
      assert item_price.id == Map.get(params, "id")
      assert item_price.is_taxable == Map.get(params, "is_taxable")
      assert item_price.item_id == Map.get(params, "item_id")
      assert item_price.item_type == Map.get(params, "item_type")
      assert item_price.name == Map.get(params, "name")
      assert item_price.period == Map.get(params, "period")
      assert item_price.period_unit == Map.get(params, "period_unit")
      assert item_price.price == Map.get(params, "price")
      assert item_price.pricing_model == Map.get(params, "pricing_model")
      assert item_price.resource_version == Map.get(params, "resource_version")
      assert item_price.status == Map.get(params, "status")
      assert item_price.updated_at == Map.get(params, "updated_at")
    end
  end
end
