defmodule Chargebeex.Quote do
  use TypedStruct

  use Chargebeex.Resource,
    resource: "quote",
    only: [:retrieve, :list]

  @typedoc """
  "create_subscription_for_customer" | "change_subscription" | "onetime_invoice"
  """
  @type operation_type :: String.t()

  @typedoc """
  "tax_exclusive" | "tax_inclusive"
  """
  @type price_type :: String.t()

  @typedoc """
  "open" | "accepted" | "declined" | "invoiced" | "closed"
  """
  @type status :: String.t()

  typedstruct do
    field :id, String.t()
    field :amount_due, non_neg_integer()
    field :amount_paid, non_neg_integer()
    field :billing_address, map()
    field :business_entity_id, String.t()
    field :charge_on_acceptance, non_neg_integer()
    field :contract_term_end, non_neg_integer()
    field :contract_term_start, non_neg_integer()
    field :contract_term_termination_fee, non_neg_integer()
    field :credits_applied, non_neg_integer()
    field :currency_code, String.t()
    field :customer_id, String.t()
    field :date, non_neg_integer()
    field :discounts, list()
    field :invoice_id, String.t()
    field :line_item_discounts, list()
    field :line_item_taxes, list()
    field :line_item_tiers, list()
    field :line_items, list()
    field :name, String.t()
    field :notes, list()
    field :operation_type, operation_type()
    field :po_number, String.t()
    field :price_type, price_type()
    field :resource_version, non_neg_integer()
    field :shipping_address, map()
    field :status, status()
    field :sub_total, non_neg_integer()
    field :subscription_id, String.t()
    field :taxes, list()
    field :total, non_neg_integer()
    field :total_payable, non_neg_integer()
    field :updated_at, non_neg_integer()
    field :valid_till, non_neg_integer()
    field :vat_number, String.t()
    field :vat_number_prefix, String.t()
    field :version, pos_integer()
    field :resources, map(), default: %{}
  end

  @moduledoc """
  Struct that represent a Chargebee's API quote.
  """
  use ExConstructor, :build

  @doc """
    Changes the quote produced for creating a new subscription items
    (operation_type = `create_subscription_for_customer`)
  """
  def edit_create_subscription_quote_for_items(id, params, opts \\ []),
    do:
      generic_action(:post, "quote", "edit_create_subscription_quote_for_items", id, params, opts)

  @doc """
    Changes the quote produced for updating the subscription items.
    (operation_type = `change_subscription`)
  """
  def edit_update_subscription_quote_for_items(id, params, opts \\ []),
    do:
      generic_action(:post, "quote", "edit_update_subscription_quote_for_items", id, params, opts)

  @doc """
    Changes the quote produced for adding one-time charges and charge items.
    (operation_type = `onetime_invoice`)
  """
  def edit_for_charge_items_and_charges(id, params, opts \\ []),
    do: generic_action(:post, "quote", "edit_for_charge_items_and_charges", id, params, opts)
end
