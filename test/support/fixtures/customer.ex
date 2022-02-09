defmodule Chargebeex.Fixtures.Customer do
  def customer_params() do
    """
    {
      "allow_direct_debit": false,
      "auto_collection": "off",
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
      "updated_at": 1612890938
    }
    """
  end
end
