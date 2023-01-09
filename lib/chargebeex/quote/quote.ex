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
  def build(raw_data) do
    attrs = %{
      id: raw_data["id"],
      amount_due: raw_data["amount_due"],
      amount_paid: raw_data["amount_paid"],
      billing_address: raw_data["billing_address"],
      business_entity_id: raw_data["business_entity_id"],
      charge_on_acceptance: raw_data["charge_on_acceptance"],
      contract_term_end: raw_data["contract_term_end"],
      contract_term_start: raw_data["contract_term_start"],
      contract_term_termination_fee: raw_data["contract_term_termination_fee"],
      credits_applied: raw_data["credits_applied"],
      currency_code: raw_data["currency_code"],
      customer_id: raw_data["customer_id"],
      date: raw_data["date"],
      discounts: raw_data["discounts"],
      invoice_id: raw_data["invoice_id"],
      line_item_discounts: raw_data["line_item_discounts"],
      line_item_taxes: raw_data["line_item_taxes"],
      line_item_tiers: raw_data["line_item_tiers"],
      line_items: raw_data["line_items"],
      name: raw_data["name"],
      notes: raw_data["notes"],
      operation_type: raw_data["operation_type"],
      po_number: raw_data["po_number"],
      price_type: raw_data["price_type"],
      resource_version: raw_data["resource_version"],
      shipping_address: raw_data["shipping_address"],
      status: raw_data["status"],
      sub_total: raw_data["sub_total"],
      subscription_id: raw_data["subscription_id"],
      taxes: raw_data["taxes"],
      total: raw_data["total"],
      total_payable: raw_data["total_payable"],
      updated_at: raw_data["updated_at"],
      valid_till: raw_data["valid_till"],
      vat_number: raw_data["vat_number"],
      vat_number_prefix: raw_data["vat_number_prefix"],
      version: raw_data["version"]
    }

    struct(__MODULE__, attrs)
  end

  @doc """
    Changes the quote produced for creating a new subscription items
    (operation_type = `create_subscription_for_customer`)
  """
  def edit_create_subscription_quote_for_items(id, params),
    do: generic_action(:post, "quote", "edit_create_subscription_quote_for_items", id, params)

  @doc """
    Changes the quote produced for updating the subscription items.
    (operation_type = `change_subscription`)
  """
  def edit_update_subscription_quote_for_items(id, params),
    do: generic_action(:post, "quote", "edit_update_subscription_quote_for_items", id, params)

  @doc """
    Changes the quote produced for adding one-time charges and charge items.
    (operation_type = `onetime_invoice`)
  """
  def edit_for_charge_items_and_charges(id, params),
    do: generic_action(:post, "quote", "edit_for_charge_items_and_charges", id, params)
end
