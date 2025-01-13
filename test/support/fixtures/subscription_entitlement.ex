defmodule Chargebeex.Fixtures.SubscriptionEntitlement do
  def subscription_entitlement_params() do
    """
    {
      "subscription_id": "Azq8g8ULPXqdL6zM",
      "feature_id": "xero-integration",
      "feature_name": "Xero Integration",
      "feature_type": "SWITCH",
      "value": "true",
      "name": "Available",
      "is_overridden": true,
      "is_enabled": true,
      "object": "subscription_entitlement"
    }
    """
  end

  def retrieve() do
    """
    {
      "subscription_entitlement": #{subscription_entitlement_params()}
    }
    """
  end

  def list() do
    """
    {
      "list": [
        #{retrieve()}
      ],
      "next_offset": "1612890918000"
    }
    """
  end
end
