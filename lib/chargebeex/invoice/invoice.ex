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

  use ExConstructor, :build
end
