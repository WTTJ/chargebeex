defmodule Chargebeex.Fixtures.Card do
  def card_params() do
    """
    {
      "card_type": "american_express",
      "created_at": 1517486946,
      "customer_id": "__test__XpbTXGTSRp3ELNCY",
      "expiry_month": 12,
      "expiry_year": 2022,
      "funding_type": "not_known",
      "gateway": "chargebee",
      "gateway_account_id": "gw___test__5SK2lMgOSRp3BOO1y",
      "iin": "378282",
      "last4": "0005",
      "masked_number": "***********0005",
      "object": "card",
      "payment_source_id": "pm___test__XpbTXGTSRp3ENNCc",
      "resource_version": 1517486946205,
      "status": "valid",
      "updated_at": 1517486946
    }
    """
  end

  def retrieve() do
    """
    {
      "card": #{card_params()}
    }
    """
  end
end
