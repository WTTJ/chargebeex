defmodule Chargebeex.Builder.AttachedItemTest do
  use ExUnit.Case, async: true

  alias Chargebeex.Builder
  alias Chargebeex.Fixtures.AttachedItem, as: AttachedItemFixture
  alias Chargebeex.AttachedItem

  describe "build/1" do
    test "should build an attached_item" do
      builded =
        AttachedItemFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()

      assert %{"attached_item" => %AttachedItem{}} = builded
    end

    test "should have the attached_item params" do
      attached_item =
        AttachedItemFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()
        |> Map.get("attached_item")

      params = AttachedItemFixture.attached_item_params() |> Jason.decode!()

      assert attached_item.id == Map.get(params, "id")
      assert attached_item.parent_item_id == Map.get(params, "parent_item_id")
      assert attached_item.item_id == Map.get(params, "item_id")
      assert attached_item.type == Map.get(params, "type")
      assert attached_item.status == Map.get(params, "status")
      assert attached_item.quantity == Map.get(params, "quantity")
      assert attached_item.quantity_in_decimals == Map.get(params, "quantity_in_decimals")
      assert attached_item.billing_cycles == Map.get(params, "billing_cycles")
      assert attached_item.charge_on_event == Map.get(params, "charge_on_event")
      assert attached_item.charge_once == Map.get(params, "charge_once")
      assert attached_item.resource_version == Map.get(params, "resource_version")
      assert attached_item.channel == Map.get(params, "channel")
      assert attached_item.updated_at == Map.get(params, "updated_at")
      assert attached_item.created_at == Map.get(params, "created_at")
    end
  end
end
