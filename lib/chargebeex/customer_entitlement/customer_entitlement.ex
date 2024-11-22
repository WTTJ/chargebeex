defmodule Chargebeex.CustomerEntitlement do
  use TypedStruct

  @resource "customer_entitlement"
  use Chargebeex.Resource, resource: @resource, only: []

  @moduledoc """
  Struct that represent a Chargebee's API customer entitlement resource.
  """

  typedstruct do
    field :customer_id, String.t()
    field :subscription_id, String.t()
    field :feature_id, String.t()
    field :value, String.t()
    field :name, String.t()
    field :is_enabled, boolean()
    field :object, String.t()
  end

  use ExConstructor, :build

  @doc """
  Allows to list Customer Entitlements

  Available filters can be found here: https://apidocs.chargebee.com/docs/api/customer_entitlements#list_customer_entitlements

  ## Examples

      iex> filters = %{limit: 2}
      iex(2)> Chargebeex.CustomerEntitlement.list(filters)
      {:ok, [%Chargebeex.CustomerEntitlement{...}, %Chargebeex.CustomerEntitlement{...}], %{"next_offset" => nil}}
  """
  def list(customer_id, params \\ %{}, opts \\ []) do
    nested_generic_action_without_id(
      :get,
      [customer: customer_id],
      @resource,
      "customer_entitlements",
      params,
      opts
    )
  end
end
