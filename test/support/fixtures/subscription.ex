defmodule Chargebeex.Fixtures.Subscription do
  def list() do
    """
    {
      "list": [
          {
              "customer": {
                  "allow_direct_debit": false,
                  "auto_collection": "off",
                  "card_status": "no_card",
                  "created_at": 1612890919,
                  "deleted": false,
                  "excess_payments": 0,
                  "first_name": "John",
                  "id": "__test__8asukSOXdvg4PD",
                  "last_name": "Doe",
                  "net_term_days": 0,
                  "object": "customer",
                  "pii_cleared": "active",
                  "preferred_currency_code": "USD",
                  "promotional_credits": 0,
                  "refundable_credits": 0,
                  "resource_version": 1612890919000,
                  "taxability": "taxable",
                  "unbilled_charges": 0,
                  "updated_at": 1612890919
              },
              "subscription": {
                  "activated_at": 1612890920,
                  "billing_period": 1,
                  "billing_period_unit": "month",
                  "created_at": 1612890920,
                  "currency_code": "USD",
                  "current_term_end": 1615310120,
                  "current_term_start": 1612890920,
                  "customer_id": "__test__8asukSOXdvg4PD",
                  "deleted": false,
                  "due_invoices_count": 1,
                  "due_since": 1612890920,
                  "has_scheduled_changes": false,
                  "id": "__test__8asukSOXdvliPG",
                  "mrr": 0,
                  "next_billing_at": 1615310120,
                  "object": "subscription",
                  "remaining_billing_cycles": 1,
                  "resource_version": 1612890920000,
                  "started_at": 1612890920,
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
                  "updated_at": 1612890920
              }
          }
      ],
      "next_offset": "1612890918000"
    }
    """
  end
end
