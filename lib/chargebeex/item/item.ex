defmodule Chargebeex.Item do
  @moduledoc """
  Struct that represent a Chargebee's API item resource.
  """

  defstruct [
    :id,
    :name,
    :external_name,
    :description,
    :status,
    :resouce_version,
    :updated_at,
    :item_family_id,
    :type,
    :redirect_url,
    :included_in_mrr,
    :item_applicability,
    :gift_claim_redirect_url,
    :unit,
    :usage_calculation,
    :archived_at,
    :channel,
    is_shippable: false,
    is_giftable: false,
    enabled_for_checkout: true,
    enabled_in_portal: true,
    metered: false,
    metadata: %{},
    applicable_items: []
  ]

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

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          external_name: String.t() | nil,
          description: String.t() | nil,
          status: status() | nil,
          resouce_version: non_neg_integer() | nil,
          updated_at: non_neg_integer() | nil,
          item_family_id: String.t() | nil,
          type: type() | nil,
          is_shippable: boolean(),
          is_giftable: boolean(),
          redirect_url: String.t() | nil,
          enabled_for_checkout: boolean(),
          enabled_in_portal: boolean(),
          included_in_mrr: boolean() | nil,
          item_applicability: item_applicability() | nil,
          gift_claim_redirect_url: String.t() | nil,
          unit: String.t() | nil,
          metered: boolean(),
          usage_calculation: usage_calculation() | nil,
          archived_at: non_neg_integer() | nil,
          channel: channel() | nil,
          metadata: %{} | nil,
          applicable_items: [%{id: String.t()}]
        }

  use Chargebeex.Resource, resource: "item"

  def build(raw_data) do
    attrs = %{
      id: raw_data["id"],
      name: raw_data["name"],
      external_name: raw_data["external_name"],
      description: raw_data["description"],
      status: raw_data["status"],
      resouce_version: raw_data["resouce_version"],
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
