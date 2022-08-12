defmodule Chargebeex.ItemPrice do
  @moduledoc """
  Struct that represent a Chargebee's API item price resource.
  """

  defstruct [
    :id,
    :name,
    :item_family_id,
    :item_id,
    :description,
    :status,
    :external_name,
    :pricing_model,
    :resource_version,
    :price,
    :price_in_decimal,
    :period,
    :currency_code,
    :period_unit,
    :trial_period,
    :trial_period_unit,
    :trial_end_action,
    :shipping_period,
    :shipping_period_unit,
    :billing_cycles,
    :free_quantity,
    :free_quantity_in_decimal,
    :channel,
    :updated_at,
    :created_at,
    :archived_at,
    :invoice_notes,
    :item_type,
    :show_description_in_invoices,
    :show_description_in_quotes,
    is_taxable: true,
    metadata: %{},
    tiers: %{},
    tax_detail: %{},
    accounting_detail: %{}
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

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          item_family_id: String.t(),
          item_id: String.t(),
          description: String.t(),
          status: status(),
          external_name: String.t(),
          pricing_model: pricing_model(),
          resource_version: String.t(),
          price: non_neg_integer(),
          price_in_decimal: String.t(),
          period: non_neg_integer(),
          currency_code: String.t(),
          period_unit: period_unit(),
          trial_period: non_neg_integer(),
          trial_period_unit: String.t(),
          trial_end_action: trial_end_action(),
          shipping_period: non_neg_integer(),
          shipping_period_unit: period_unit(),
          billing_cycles: non_neg_integer(),
          free_quantity: non_neg_integer(),
          free_quantity_in_decimal: String.t(),
          channel: channel(),
          updated_at: non_neg_integer(),
          created_at: non_neg_integer(),
          archived_at: non_neg_integer(),
          invoice_notes: String.t(),
          metadata: map(),
          item_type: type(),
          show_description_in_invoices: boolean,
          show_description_in_quotes: boolean,
          is_taxable: boolean(),
          tiers: %{},
          tax_detail: %{},
          accounting_detail: %{}
        }

  use Chargebeex.Resource, resource: "item_price"

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
