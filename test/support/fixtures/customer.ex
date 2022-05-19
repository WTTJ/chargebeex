defmodule Chargebeex.Fixtures.Customer do
  def customer_params() do
    """
    {
      "allow_direct_debit": false,
      "auto_collection": "off",
      "billing_address": {
        "city": "Walnut",
        "country": "US",
        "first_name": "John",
        "last_name": "Doe",
        "line1": "PO Box 9999",
        "object": "billing_address",
        "state": "California",
        "state_code": "CA",
        "validation_status": "not_validated",
        "zip": "91789"
      },
      "card_status": "no_card",
      "created_at": 1612890938,
      "deleted": false,
      "excess_payments": 0,
      "first_name": "John",
      "id": "__test__8asukSOXe0QYSR",
      "last_name": "Doe",
      "net_term_days": 0,
      "object": "customer",
      "pii_cleared": "active",
      "preferred_currency_code": "USD",
      "promotional_credits": 0,
      "refundable_credits": 0,
      "resource_version": 1612890938000,
      "taxability": "taxable",
      "unbilled_charges": 0,
      "updated_at": 1612890938,
      "vat_number": "55802162628",
      "vat_number_status": "valid",
      "vat_number_validated_time": "1649946996",
      "primary_payment_source_id": "pm_198avhT6H0gYlLyG",
      "backup_payment_source_id": "pm_198avhT6H0gYlLyH"
    }
    """
  end

  def retrieve() do
    """
    {
      "customer": #{customer_params()}
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
