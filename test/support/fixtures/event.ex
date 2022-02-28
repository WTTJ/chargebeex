defmodule Chargebeex.Fixtures.Event do
  def event_params() do
    """
    {
      "api_version": "v2",
      "content": {
        "customer": {
          "allow_direct_debit": false,
          "auto_collection": "off",
          "card_status": "no_card",
          "created_at": 1517505958,
          "deleted": false,
          "excess_payments": 0,
          "id": "__test__KyVnHhSBWm4tg2rq",
          "net_term_days": 0,
          "object": "customer",
          "pii_cleared": "active",
          "preferred_currency_code": "USD",
          "promotional_credits": 0,
          "refundable_credits": 0,
          "resource_version": 1517505958000,
          "taxability": "taxable",
          "unbilled_charges": 0,
          "updated_at": 1517505958
      }},
      "event_type": "customer_created",
      "id": "ev___test__KyVnHhSBWm4wM2ru",
      "object": "event",
      "occurred_at": 1517505959,
      "source": "api",
      "user": "full_access_key_v1",
      "webhook_status": "scheduled"
    }
    """
  end

  def retrieve() do
    """
    {
      "event": #{event_params()}
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
