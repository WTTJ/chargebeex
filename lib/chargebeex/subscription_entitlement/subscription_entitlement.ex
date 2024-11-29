defmodule Chargebeex.SubscriptionEntitlement do
  use TypedStruct

  @resource "subscription_entitlement"
  use Chargebeex.Resource, resource: @resource, only: []

  @moduledoc """
  Struct that represent a Chargebee's API subscription entitlement resource.
  """

  @typedoc """
  "switch" | "custom" | "quantity" | "range"
  """
  @type feature_type :: String.t()

  typedstruct do
    field :subscription_id, String.t()
    field :feature_id, String.t()
    field :feature_name, String.t()
    field :feature_type, feature_type()
    field :value, String.t()
    field :name, String.t()
    field :is_overridden, boolean()
    field :is_enabled, boolean()
    field :object, String.t()
  end

  use ExConstructor, :build

  @doc """
  Allows to list Subscription Entitlements

  Available filters can be found here: https://apidocs.chargebee.com/docs/api/subscription_entitlements#list_subscription_entitlements

  ## Examples

      iex> filters = %{limit: 2}
      iex(2)> Chargebeex.SubscriptionEntitlement.list(filters)
      {:ok, [%Chargebeex.SubscriptionEntitlement{...}, %Chargebeex.SubscriptionEntitlement{...}], %{"next_offset" => nil}}
  """
  def list(subscription_id, params \\ %{}, opts \\ []) do
    nested_generic_action_without_id(
      :get,
      [subscription: subscription_id],
      @resource,
      "subscription_entitlements",
      params,
      opts
    )
  end
end
