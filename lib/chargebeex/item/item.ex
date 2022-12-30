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

  def build(raw_data) do
    attrs = %{
      id: raw_data["id"],
      name: raw_data["name"],
      external_name: raw_data["external_name"],
      description: raw_data["description"],
      status: raw_data["status"],
      resource_version: raw_data["resource_version"],
      updated_at: raw_data["updated_at"],
      item_family_id: raw_data["item_family_id"],
      type: raw_data["type"],
      redirect_url: raw_data["redirect_url"],
      included_in_mrr: raw_data["included_in_mrr"],
      item_applicability: raw_data["item_applicability"],
      gift_claim_redirect_url: raw_data["gift_claim_redirect_url"],
      unit: raw_data["unit"],
      usage_calculation: raw_data["usage_calculation"],
      archived_at: raw_data["archived_at"],
      channel: raw_data["channel"],
      is_shippable: raw_data["is_shippable"],
      is_giftable: raw_data["is_giftable"],
      enabled_for_checkout: raw_data["enabled_for_checkout"],
      enabled_in_portal: raw_data["enabled_in_portal"],
      metered: raw_data["metered"],
      metadata: raw_data["metadata"],
      applicable_items: raw_data["applicable_items"]
    }

    struct(__MODULE__, attrs)
  end
end
