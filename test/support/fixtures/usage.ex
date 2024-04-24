defmodule Chargebeex.Fixtures.Usage do
  def usage_params() do
    """
    {
      "id": "a065d78c-a5a8-458b-85b6-e9295118d3bf",
      "usage_date": 1599817250,
      "subscription_id": "e49e39cf-a406-4cc9-b14a-85476b3c3ebf",
      "item_price_id": "item_eur_monthly",
      "invoice_id": "82d0478f-f424-43ae-b342-d8c516039200",
      "line_item_id": "8b602549-a0f3-4ee7-8eb8-89200fa26ca4",
      "quantity": 42,
      "source": "api",
      "resource_version": 1599817250735,
      "updated_at": 1599817250,
      "created_at": 1599817250
    }
    """
  end

  def retrieve() do
    """
    {
      "usage": #{usage_params()}
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
