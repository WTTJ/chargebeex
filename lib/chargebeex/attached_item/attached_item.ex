defmodule Chargebeex.AttachedItem do
  use TypedStruct

  @resource "attached_item"
  use Chargebeex.Resource, resource: @resource, only: []

  @moduledoc """
  Struct that represent a Chargebee's API attached item resource.
  """

  @typedoc """
  "recommended" | "mandatory" | "optional"
  """
  @type type :: String.t()

  @typedoc """
  "active" | "archived" | "deleted"
  """
  @type status :: String.t()

  @typedoc """
  "subscription_creation" | "subscription_trial_start" | "plan_activation" |
  "subscription_activation" | "contract_termination" | "on_demand"
  """
  @type charge_event :: String.t()

  @typedoc """
  "web" | "app_store" | "play_store"
  """
  @type channel :: String.t()

  typedstruct do
    field :id, String.t()
    field :parent_item_id, String.t()
    field :item_id, String.t()
    field :type, type()
    field :status, status()
    field :quantity, non_neg_integer()
    field :quantity_in_decimals, non_neg_integer()
    field :billing_cycles, non_neg_integer()
    field :charge_on_event, charge_event()
    field :charge_once, boolean()
    field :resource_version, non_neg_integer()
    field :channel, channel()
    field :created_at, non_neg_integer()
    field :updated_at, non_neg_integer()
  end

  use ExConstructor, :build

  def list(item_id, params \\ %{}, opts \\ []) do
    nested_generic_action_without_id(
      :get,
      [item: item_id],
      @resource,
      "attached_items",
      params,
      opts
    )
  end
end
