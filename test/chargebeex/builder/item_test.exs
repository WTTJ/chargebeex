defmodule Chargebeex.Builder.ItemTest do
  use ExUnit.Case, async: true

  alias Chargebeex.Builder
  alias Chargebeex.Fixtures.Item, as: ItemFixture
  alias Chargebeex.Item

  describe "build/1" do
    test "should build an item" do
      builded =
        ItemFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()

      assert %{"item" => %Item{}} = builded
    end

    test "should have the item params" do
      item =
        ItemFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()
        |> Map.get("item")

      params = ItemFixture.item_params() |> Jason.decode!()

      assert item.id == Map.get(params, "id")
      assert item.name == Map.get(params, "name")
      assert item.external_name == Map.get(params, "external_name")
      assert item.description == Map.get(params, "description")
      assert item.status == Map.get(params, "status")
      assert item.resouce_version == Map.get(params, "resouce_version")
      assert item.updated_at == Map.get(params, "updated_at")
      assert item.item_family_id == Map.get(params, "item_family_id")
      assert item.type == Map.get(params, "type")
      assert item.redirect_url == Map.get(params, "redirect_url")
      assert item.included_in_mrr == Map.get(params, "included_in_mrr")
      assert item.item_applicability == Map.get(params, "item_applicability")
      assert item.gift_claim_redirect_url == Map.get(params, "gift_claim_redirect_url")
      assert item.unit == Map.get(params, "unit")
      assert item.usage_calculation == Map.get(params, "usage_calculation")
      assert item.archived_at == Map.get(params, "archived_at")
      assert item.channel == Map.get(params, "channel")
      assert item.is_shippable == Map.get(params, "is_shippable")
      assert item.is_giftable == Map.get(params, "is_giftable")
      assert item.enabled_for_checkout == Map.get(params, "enabled_for_checkout")
      assert item.enabled_in_portal == Map.get(params, "enabled_in_portal")
      assert item.metered == Map.get(params, "metered")
      assert item.metadata == Map.get(params, "metadata")
      assert item.applicable_items == Map.get(params, "applicable_items")
    end
  end
end
