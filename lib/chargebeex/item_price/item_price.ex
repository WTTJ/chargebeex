defmodule Chargebeex.ItemPrice do
  use TypedStruct

  use Chargebeex.Resource, resource: "item_price"

  @moduledoc """
  Struct that represent a Chargebee's API item price resource.
  """

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
  "flat_fee" | "per_unit" | "tiered" | "volume" | "stairstep"
  """
  @type pricing_model :: String.t()

  @typedoc """
  "web" | "app_store" | "play_store"
  """
  @type channel :: String.t()

  @typedoc """
  "day" | "week" | "month" | "year"
  """
  @type period_unit :: String.t()

  @typedoc """
  "site_default" | "activate_subscription" | "cancel_subscription"
  """
  @type trial_end_action :: String.t()

  typedstruct do
    field :id, String.t()
    field :name, String.t()
    field :item_family_id, String.t()
    field :item_id, String.t()
    field :description, String.t()
    field :status, status()
    field :external_name, String.t()
    field :pricing_model, pricing_model()
    field :resource_version, String.t()
    field :price, non_neg_integer()
    field :price_in_decimal, String.t()
    field :period, non_neg_integer()
    field :currency_code, String.t()
    field :period_unit, non_neg_integer()
    field :trial_period, non_neg_integer()
    field :trial_period_unit, String.t()
    field :trial_end_action, trial_end_action()
    field :shipping_period, non_neg_integer()
    field :shipping_period_unit, period_unit()
    field :billing_cycles, non_neg_integer()
    field :free_quantity, non_neg_integer()
    field :free_quantity_in_decimal, String.t()
    field :channel, channel()
    field :updated_at, non_neg_integer()
    field :created_at, non_neg_integer()
    field :archived_at, non_neg_integer()
    field :invoice_notes, String.t()
    field :item_type, type()
    field :show_description_in_invoices, boolean()
    field :show_description_in_quotes, boolean()
    field :is_taxable, boolean(), default: true
    field :metadata, map(), default: %{}
    field :tiers, map(), default: %{}
    field :tax_detail, map(), default: %{}
    field :accounting_detail, map(), default: %{}
  end

  def build(raw_data) do
    attrs = %{
      id: raw_data["id"],
      name: raw_data["name"],
      item_family_id: raw_data["item_family_id"],
      item_id: raw_data["item_id"],
      description: raw_data["description"],
      status: raw_data["status"],
      external_name: raw_data["external_name"],
      pricing_model: raw_data["pricing_model"],
      resource_version: raw_data["resource_version"],
      price: raw_data["price"],
      price_in_decimal: raw_data["price_in_decimal"],
      period: raw_data["period"],
      currency_code: raw_data["currency_code"],
      period_unit: raw_data["period_unit"],
      trial_period: raw_data["trial_period"],
      trial_period_unit: raw_data["trial_period_unit"],
      trial_end_action: raw_data["trial_end_action"],
      shipping_period: raw_data["shipping_period"],
      shipping_period_unit: raw_data["shipping_period_unit"],
      billing_cycles: raw_data["billing_cycles"],
      free_quantity: raw_data["free_quantity"],
      free_quantity_in_decimal: raw_data["free_quantity_in_decimal"],
      channel: raw_data["channel"],
      updated_at: raw_data["updated_at"],
      created_at: raw_data["created_at"],
      archived_at: raw_data["archived_at"],
      invoice_notes: raw_data["invoice_notes"],
      item_type: raw_data["item_type"],
      show_description_in_invoices: raw_data["show_description_in_invoices"],
      show_description_in_quotes: raw_data["show_description_in_quotes"],
      is_taxable: raw_data["is_taxable"],
      metadata: raw_data["metadata"],
      tiers: raw_data["tiers"],
      tax_detail: raw_data["tax_detail"],
      accounting_detail: raw_data["accounting_detail"]
    }

    struct(__MODULE__, attrs)
  end
end
