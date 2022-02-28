defmodule Chargebeex.Fixtures.Subscription do
  alias Chargebeex.Fixtures.Customer

  def subscription_params() do
    """
      {
        "activated_at": 1612890938,
        "billing_period": 1,
        "billing_period_unit": "month",
        "created_at": 1612890938,
        "currency_code": "USD",
        "current_term_end": 1615310138,
        "current_term_start": 1612890938,
        "customer_id": "__test__8asukSOXe0QYSR",
        "deleted": false,
        "due_invoices_count": 1,
        "due_since": 1612890938,
        "has_scheduled_changes": false,
        "id": "__test__8asukSOXe0W3SU",
        "mrr": 0,
        "next_billing_at": 1615310138,
        "object": "subscription",
        "remaining_billing_cycles": 1,
        "resource_version": 1612890938000,
        "started_at": 1612890938,
        "status": "active",
        "subscription_items": [
            {
                "amount": 1000,
                "billing_cycles": 1,
                "free_quantity": 0,
                "item_price_id": "basic-USD",
                "item_type": "plan",
                "object": "subscription_item",
                "quantity": 1,
                "unit_price": 1000
            }
        ],
        "total_dues": 1100,
        "updated_at": 1612890938
    }
    """
  end

  def retrieve() do
    """
    {
      "customer": #{Customer.customer_params()},
      "subscription": #{subscription_params()}
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
