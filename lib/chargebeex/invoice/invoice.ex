defmodule Chargebeex.Invoice do
  use TypedStruct
  use Chargebeex.Resource, resource: "invoice"

  typedstruct do
    field :adjustment_credit_notes, list()
    field :amount_adjusted, integer()
    field :amount_due, integer()
    field :amount_paid, integer()
    field :amount_to_collect, integer()
    field :applied_credits, list()
    field :base_currency_code, String.t()
    field :billing_address, map()
    field :credits_applied, integer()
    field :currency_code, String.t()
    field :customer_id, String.t()
    field :date, integer()
    field :deleted, boolean()
    field :due_date, integer()
    field :dunning_attempts, list()
    field :exchange_rate, integer()
    field :first_invoice, boolean()
    field :has_advance_charges, boolean()
    field :id, String.t()
    field :is_gifted, boolean()
    field :issued_credit_notes, list()
    field :line_items, list()
    field :linked_orders, list()
    field :linked_payments, list()
    field :net_term_days, integer()
    field :new_sales_amount, integer()
    field :object, map()
    field :paid_at, integer()
    field :price_type, String.t()
    field :recurring, boolean()
    field :resource_version, integer()
    field :round_off_amount, integer()
    field :shipping_address, map()
    field :status, String.t()
    field :sub_total, integer()
    field :subscription_id, String.t()
    field :tax, integer()
    field :term_finalized, boolean()
    field :total, integer()
    field :updated_at, integer()
    field :write_off_amount, integer()
    field :resources, map(), default: %{}
  end

  def build(raw_data) do
    attrs = %{
      adjustment_credit_notes: raw_data["adjustment_credit_notes"],
      amount_adjusted: raw_data["amount_adjusted"],
      amount_due: raw_data["amount_due"],
      amount_paid: raw_data["amount_paid"],
      amount_to_collect: raw_data["amount_to_collect"],
      applied_credits: raw_data["applied_credits"],
      base_currency_code: raw_data["base_currency_code"],
      billing_address: raw_data["billing_address"],
      credits_applied: raw_data["credits_applied"],
      currency_code: raw_data["currency_code"],
      customer_id: raw_data["customer_id"],
      date: raw_data["date"],
      deleted: raw_data["deleted"],
      due_date: raw_data["due_date"],
      dunning_attempts: raw_data["dunning_attempts"],
      exchange_rate: raw_data["exchange_rate"],
      first_invoice: raw_data["first_invoice"],
      has_advance_charges: raw_data["has_advance_charges"],
      id: raw_data["id"],
      is_gifted: raw_data["is_gifted"],
      issued_credit_notes: raw_data["issued_credit_notes"],
      line_items: raw_data["line_items"],
      linked_orders: raw_data["linked_orders"],
      linked_payments: raw_data["linked_payments"],
      net_term_days: raw_data["net_term_days"],
      new_sales_amount: raw_data["new_sales_amount"],
      object: raw_data["object"],
      paid_at: raw_data["paid_at"],
      price_type: raw_data["price_type"],
      recurring: raw_data["recurring"],
      resource_version: raw_data["resource_version"],
      round_off_amount: raw_data["round_off_amount"],
      shipping_address: raw_data["shipping_address"],
      status: raw_data["status"],
      sub_total: raw_data["sub_total"],
      subscription_id: raw_data["subscription_id"],
      tax: raw_data["tax"],
      term_finalized: raw_data["term_finalized"],
      total: raw_data["total"],
      updated_at: raw_data["updated_at"],
      write_off_amount: raw_data["write_off_amount"]
    }

    struct(__MODULE__, attrs)
  end
end
