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

  use ExConstructor, :build
end
