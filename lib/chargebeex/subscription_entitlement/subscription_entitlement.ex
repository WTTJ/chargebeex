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

  @typedoc """
  A single entitlement override map.
  """
  @type subscription_entitlement :: %{
          required(:feature_id) => String.t()
        }

  @typedoc """
  Parameters for the `set_availability` function.
  """
  @type set_availability_params :: %{
          required(:is_enabled) => boolean(),
          optional(:subscription_entitlements) => [subscription_entitlement()],
          optional(any()) => any()
        }

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

  @doc """
  Enables or disables specific subscription_entitlements for a subscription.


  For more info, check the API doc: https://apidocs.eu.chargebee.com/docs/api/subscription_entitlements?lang=curl#enable/disable_subscription_entitlements

  ## Examples
  #
      iex(1)> subscription_id = "BTLybZUInBGCXDMY"
      "BTLybZUInBGCXDMY"
      iex(2)> params = %{
      ...(2)>   "is_enabled" => true,
      ...(2)>   "subscription_entitlements" => [
      ...(2)>     %{
      ...(2)>       "feature_id" => "foo_feature"
      ...(2)>     }
      ...(2)>   ]
      ...(2)> }
      %{
        "is_enabled" => true,
        "subscription_entitlements" => [
          %{"feature_id" => "foo_feature"}
        ]
      }
      iex(3)> Chargebeex.SubscriptionEntitlement.set_availability(subscription_id, params)
      {:ok,
       [%Chargebeex.SubscriptionEntitlement{...}], %{"next_offset" => nil}}
  """
  @spec set_availability(String.t(), set_availability_params(), keyword()) :: any()
  def set_availability(subscription_id, params, opts \\ [])

  def set_availability(
        subscription_id,
        %{"is_enabled" => _is_enabled, "subscription_entitlements" => _entitlements} = params,
        opts
      ) do
    nested_generic_action_without_id(
      :post,
      [subscription: subscription_id],
      @resource,
      "subscription_entitlements/set_availability",
      params,
      opts
    )
  end

  def set_availability(_subscription_id, _params, _opts) do
    raise ArgumentError, """
    Invalid params provided to `set_availability`. Ensure that `params["is_enabled"]` and `params["subscription_entitlements"]` are provided.
    """
  end
end
