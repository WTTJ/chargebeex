defmodule Chargebeex.Fixtures.ItemPrice do
  def item_price_params() do
    """
    {
      "created_at": 1594106945,
      "currency_code": "USD",
      "external_name": "basic USD",
      "free_quantity": 0,
      "id": "basic-USD-monthly",
      "is_taxable": true,
      "item_id": "basic",
      "item_type": "plan",
      "name": "basic USD monthly",
      "object": "item_price",
      "period": 1,
      "period_unit": "month",
      "price": 1000,
      "pricing_model": "per_unit",
      "resource_version": 1594106945077,
      "status": "active",
      "updated_at": 1594106945
    }
    """
  end

  def retrieve() do
    """
    {
      "item_price": #{item_price_params()}
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
