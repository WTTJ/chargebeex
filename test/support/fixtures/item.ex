defmodule Chargebeex.Fixtures.Item do
  def item_params() do
    """
    {
      "enabled_for_checkout": true,
      "enabled_in_portal": true,
      "id": "cbdemo_additionaluser",
      "is_giftable": false,
      "is_shippable": false,
      "name": "CbDemo Additional User",
      "object": "item",
      "resource_version": 1599817250735,
      "status": "active",
      "type": "addon",
      "updated_at": 1599817250
    }
    """
  end

  def retrieve() do
    """
    {
      "item": #{item_params()}
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
