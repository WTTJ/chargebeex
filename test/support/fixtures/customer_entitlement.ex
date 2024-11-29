defmodule Chargebeex.Fixtures.CustomerEntitlement do
  def customer_entitlement_params() do
    """
    {
      "customer_id": "cus01",
      "subscription_id": "sub123",
      "feature_id": "licenses",
      "feature_name": "Xero Integration",
      "value": "60",
      "name": "60 licenses",
      "is_enabled": true,
      "object": "customer_entitlement"
    }
    """
  end

  def retrieve() do
    """
    {
      "customer_entitlement": #{customer_entitlement_params()}
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
