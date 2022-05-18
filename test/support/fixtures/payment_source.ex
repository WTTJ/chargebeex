defmodule Chargebeex.Fixtures.PaymentSource do
  def payment_source_params() do
    """
    {
      "card": {
        "brand": "visa",
        "expiry_month": 5,
        "expiry_year": 2022,
        "first_name": "MyCard",
        "funding_type": "credit",
        "iin": "******",
        "last4": "4242",
        "last_name": "testing",
        "masked_number": "************4242",
        "object": "card"
      },
      "created_at": 1517487233,
      "customer_id": "__test__XpbTXGTSRp4QZ1EK",
      "deleted": false,
      "gateway": "stripe",
      "gateway_account_id": "gw___test__5SK2lMpwSRp4Mx02v",
      "id": "pm___test__XpbTXGTSRp4R8ZEN",
      "issuing_country": "US",
      "object": "payment_source",
      "reference_id": "cus_J7rVykqiooX1ng/card_1IVbmWJv9j0DyntJS7Bzo5q5",
      "resource_version": 1517487233588,
      "status": "valid",
      "type": "card",
      "updated_at": 1517487233
      }
    """
  end

  def retrieve() do
    """
    {
      "payment_source": #{payment_source_params()}
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
