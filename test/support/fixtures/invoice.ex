defmodule Chargebeex.Fixtures.Invoice do
  def invoice_params() do
    """
    {
      "adjustment_credit_notes": [],
      "amount_adjusted": 0,
      "amount_due": 0,
      "amount_paid": 1000,
      "amount_to_collect": 0,
      "applied_credits": [],
      "base_currency_code": "USD",
      "billing_address": {
          "first_name": "John",
          "last_name": "Mathew",
          "object": "billing_address",
          "validation_status": "not_validated"
      },
      "credits_applied": 0,
      "currency_code": "USD",
      "customer_id": "__test__8asyKSOcTHxf1V",
      "date": 1517490266,
      "deleted": false,
      "due_date": 1517490266,
      "dunning_attempts": [],
      "exchange_rate": 1,
      "first_invoice": true,
      "has_advance_charges": false,
      "id": "__demo_inv__7",
      "is_gifted": false,
      "issued_credit_notes": [
        {
          "cn_create_reason_code": "Subscription Change",
          "cn_date": 1517490267,
          "cn_id": "__demo_cn__2",
          "cn_reason_code": "subscription_change",
          "cn_status": "refunded",
          "cn_total": 1000
        }
      ],
      "line_items": [
        {
          "amount": 1000,
          "customer_id": "__test__8asyKSOcTHxf1V",
          "date_from": 1517490266,
          "date_to": 1519909466,
          "description": "basic USD",
          "discount_amount": 0,
          "entity_id": "basic-USD",
          "entity_type": "plan_item_price",
          "id": "li___test__8asyKSOcTI6v1e",
          "is_taxed": false,
          "item_level_discount_amount": 0,
          "object": "line_item",
          "pricing_model": "per_unit",
          "quantity": 1,
          "subscription_id": "__test__8asyKSOcTI3k1c",
          "tax_amount": 0,
          "tax_exempt_reason": "tax_not_configured",
          "unit_amount": 1000
        }
      ],
      "linked_orders": [],
      "linked_payments": [
          {
            "applied_amount": 1000,
            "applied_at": 1517490266,
            "txn_amount": 1000,
            "txn_date": 1517490266,
            "txn_id": "txn___test__8asyKSOcTIAy1f",
            "txn_status": "success"
          }
      ],
      "net_term_days": 0,
      "new_sales_amount": 1000,
      "object": "invoice",
      "paid_at": 1517490266,
      "price_type": "tax_exclusive",
      "recurring": true,
      "resource_version": 1517490268022,
      "round_off_amount": 0,
      "status": "paid",
      "sub_total": 1000,
      "subscription_id": "__test__8asyKSOcTI3k1c",
      "tax": 0,
      "term_finalized": true,
      "total": 1000,
      "updated_at": 1517490268,
      "write_off_amount": 0
    }
    """
  end

  def retrieve() do
    """
    {
      "invoice": #{invoice_params()}
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
