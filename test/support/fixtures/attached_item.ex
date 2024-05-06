defmodule Chargebeex.Fixtures.AttachedItem do
  def attached_item_params() do
    """
    {
      "id": "a065d78c-a5a8-458b-85b6-e9295118d3bf",
      "parent_item_id": "16d8d51c-9d6f-47d0-9a50-7de1468e5131",
      "item_id": "48591bc6-fc7b-442c-90c2-14758c16bc2f",
      "type": "mandatory",
      "status": "active",
      "quantity": 1,
      "quantity_in_decimal": 10,
      "billing_cycles": 1,
      "charge_on_event": "on_demand",
      "charge_once": false,
      "resource_version": 1599817250735,
      "channel": "web",
      "updated_at": 1599817250,
      "created_at": 1599817250
    }
    """
  end

  def retrieve() do
    """
    {
      "attached_item": #{attached_item_params()}
    }
    """
  end

  def list() do
    """
    {
      "list": [
        #{retrieve()},
        #{retrieve()}
      ],
      "next_offset": "1612890918000"
    }
    """
  end
end
