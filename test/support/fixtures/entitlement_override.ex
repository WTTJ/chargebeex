defmodule Chargebeex.Fixtures.EntitlementOverride do
  def entitlement_override_params() do
    """
    {
      "id": "override-1935f8d6-b791-4181-9fa2-65fd8bfbd7ae",
      "entity_id": "Jdf63vklssSDFdb",
      "entity_type": "subscription",
      "feature_id": "fea-be1a9281-d8df-48ce-82e2-294667eb4d94",
      "feature_name": "Quickbooks Integration_123",
      "name": "Available",
      "object": "entitlement_override",
      "value": "true"
    }
    """
  end

  def retrieve() do
    """
    {
      "entitlement_override": #{entitlement_override_params()}
    }
    """
  end

  def list() do
    """
    {
      "list": [
        #{retrieve()}
      ]
    }
    """
  end
end
