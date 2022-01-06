defmodule ChargebeeElixir.Invoice do
  defstruct [
    :adjustment_credit_notes,
    :amount_adjusted,
    :amount_due,
    :amount_paid,
    :amount_to_collect,
    :applied_credits,
    :base_currency_code,
    :billing_address,
    :credits_applied,
    :currency_code,
    :customer_id,
    :date,
    :deleted,
    :due_date,
    :dunning_attempts,
    :exchange_rate,
    :first_invoice,
    :has_advance_charges,
    :id,
    :is_gifted,
    :issued_credit_notes,
    :line_items,
    :linked_orders,
    :linked_payments,
    :net_term_days,
    :new_sales_amount,
    :object,
    :paid_at,
    :price_type,
    :recurring,
    :resource_version,
    :round_off_amount,
    :shipping_address,
    :status,
    :sub_total,
    :tax,
    :term_finalized,
    :total,
    :updated_at,
    :write_off_amount
  ]

  @resource "invoice"
  use ChargebeeElixir.Resource, @resource

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
      tax: raw_data["tax"],
      term_finalized: raw_data["term_finalized"],
      total: raw_data["total"],
      updated_at: raw_data["updated_at"],
      write_off_amount: raw_data["write_off_amount"]
    }

    struct(__MODULE__, attrs)
  end

  # def close(id, params \\ %{}) do
  #   post_endpoint(id, "/close", params)
  # end
end
