defmodule Chargebeex.EntitlementOverride do
  use TypedStruct

  @resource "entitlement_override"
  use Chargebeex.Resource, resource: @resource, only: []

  @moduledoc """
  Struct that represent a Chargebee's API entitlement override resource.
  """

  @typedoc """
  "subscription" 
  """
  @type entity_type :: String.t()

  typedstruct do
    field :entity_id, String.t()
    field :entity_type, entity_type()
    field :feature_id, String.t()
    field :feature_name, String.t()
    field :id, String.t()
    field :name, String.t()
    field :object, String.t()
    field :value, String.t()
  end

  use ExConstructor, :build

  @typedoc """
  A single entitlement override map.
  """
  @type entitlement_override :: %{
          required(:feature_id) => String.t(),
          optional(:value) => String.t(),
          optional(:expires_at) => non_neg_integer(),
          optional(:effective_from) => non_neg_integer()
        }

  @typedoc """
  Parameters for the `upsert_or_remove` function.
  The `action` field must be either `upsert` or `remove`.
  """
  @type upsert_or_remove_params :: %{
          required(:action) => :upsert | :remove,
          optional(:entitlement_overrides) => [entitlement_override()],
          optional(any()) => any()
        }

  @doc """
  Upserts or removes a set of entitlement_overrides for a subscription depending on the action specified

  More info: https://apidocs.eu.chargebee.com/docs/api/entitlement_overrides?lang=curl#upsert/remove_entitlement_overrides_for_a_subscription

  ## Examples

    iex(1)> subscription_id = "BTLybZUInBGCXDMY"
    "BTLybZUInBGCXDMY"
    iex(2)> params = %{
    ...(2)>   "action" => :upsert,
    ...(2)>   "entitlement_overrides" => [
    ...(2)>     %{
    ...(2)>       "feature_id" => "foo",
    ...(2)>       "value" => "false"
    ...(2)>     }
    ...(2)>   ]
    ...(2)> }
    %{
      "action" => :upsert,
      "entitlement_overrides" => [
        %{"feature_id" => "foo", "value" => "false"}
      ]
    }
    iex(3)> Chargebeex.EntitlementOverride.upsert_or_remove(subscription_id, params)
    {:ok,
     [
       %Chargebeex.EntitlementOverride{...}
     ], %{"next_offset" => nil}}
  """
  @spec upsert_or_remove(String.t(), upsert_or_remove_params(), keyword()) :: any()
  def upsert_or_remove(subscription_id, params, opts \\ [])

  def upsert_or_remove(_subscription_id, %{"action" => action} = _params, _opts)
      when action not in [:upsert, :remove] do
    raise ArgumentError, """
    Invalid action provided to `upsert_or_remove`. Ensure that `params[:action]` is either `:upsert` or `:remove`.
    """
  end

  def upsert_or_remove(subscription_id, params, opts) do
    nested_generic_action_without_id(
      :post,
      [subscription: subscription_id],
      @resource,
      "entitlement_overrides",
      params,
      opts
    )
  end
end
