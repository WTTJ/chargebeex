defmodule Chargebeex.Fixtures.Quote do
  def quote_params() do
    """
    {
      "amount_due": 4500,
      "amount_paid": 0,
      "billing_address": {
        "first_name": "John",
        "last_name": "Doe",
        "object": "billing_address",
        "validation_status": "not_validated"
      },
      "charge_on_acceptance": 4500,
      "credits_applied": 0,
      "currency_code": "USD",
      "customer_id": "__test__8aszcSOcl7qp2S",
      "date": 1517494517,
      "id": "8",
      "line_item_discounts": [],
      "line_item_taxes": [],
      "line_items": [
        {
          "amount": 4000,
          "customer_id": "__test__8aszcSOcl7qp2S",
          "date_from": 1517494517,
          "date_to": 1517494517,
          "description": "Encryption Charge USD Monthly",
          "discount_amount": 0,
          "entity_id": "encryption-charge-USD",
          "entity_type": "charge_item_price",
          "id": "__test__8aszcSOcl7z92d",
          "is_taxed": false,
          "item_level_discount_amount": 0,
          "object": "line_item",
          "pricing_model": "flat_fee",
          "quantity": 1,
          "tax_amount": 0,
          "unit_amount": 4000
        },
        {
          "amount": 500,
          "customer_id": "__test__8aszcSOcl7qp2S",
          "date_from": 1517494517,
          "date_to": 1517494517,
          "description": "SSL Charge USD Monthly",
          "discount_amount": 0,
          "entity_id": "ssl-charge-USD",
          "entity_type": "charge_item_price",
          "id": "__test__8aszcSOcl7z92e",
          "is_taxed": false,
          "item_level_discount_amount": 0,
          "object": "line_item",
          "pricing_model": "flat_fee",
          "quantity": 1,
          "tax_amount": 0,
          "unit_amount": 500
        }
      ],
      "object": "quote",
      "operation_type": "onetime_invoice",
      "price_type": "tax_exclusive",
      "resource_version": 1517494517214,
      "status": "open",
      "sub_total": 4500,
      "taxes": [],
      "total": 4500,
      "total_payable": 4500,
      "updated_at": 1517494517,
      "valid_till": 1526134516,
      "version": 1
    }
    """
  end

  def retrieve() do
    """
    {
      "quote": #{quote_params()}
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
