defmodule Chargebeex.Item do
  use TypedStruct
  use Chargebeex.Resource, resource: "item"

  @typedoc """
  "active" | "archived" | "deleted"
  """
  @type status :: String.t()

  @typedoc """
  "plan" | "addon" | "charge"
  """
  @type type :: String.t()

  @typedoc """
  "all" | "restricted"
  """
  @type item_applicability :: String.t()

  @typedoc """
  "sum_of_usages" | "last_usage" | "max_usage"
  """
  @type usage_calculation :: String.t()

  @typedoc """
  "web" | "app_store" | "play_store"
  """
  @type channel :: String.t()

  @moduledoc """
  Struct that represent a Chargebee's API item resource.
  """

  typedstruct do
    field :id, String.t()
    field :name, String.t()
    field :external_name, String.t()
    field :description, String.t()
    field :status, status()
    field :resource_version, non_neg_integer()
    field :updated_at, non_neg_integer()
    field :item_family_id, String.t()
    field :type, type()
    field :redirect_url, String.t()
    field :included_in_mrr, boolean()
    field :item_applicability, item_applicability()
    field :gift_claim_redirect_url, String.t()
    field :unit, String.t()
    field :usage_calculation, usage_calculation()
    field :archived_at, non_neg_integer()
    field :channel, channel()
    field :is_shippable, boolean(), default: false
    field :is_giftable, boolean(), default: false
    field :enabled_for_checkout, boolean(), default: true
    field :enabled_in_portal, boolean(), default: true
    field :metered, boolean(), default: false
    field :metadata, map(), default: %{}
    field :applicable_items, list(), default: []
  end

  use ExConstructor, :build
end
