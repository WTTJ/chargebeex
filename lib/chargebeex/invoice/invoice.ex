defmodule Chargebeex.Invoice do
  use TypedStruct

  @resource "invoice"
  use Chargebeex.Resource, resource: @resource

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

  @doc """
  Creates an invoice for charge-items and one-time charges.

  ## Examples

      iex> Chargebeex.Invoice.create_for_charge_items_and_charges(%{
        customer_id: "__test__KyVkkWS1xLskm8",
        item_prices: [
          %{
            item_price_id: "ssl-charge-USD",
            unit_price: 2000
          }
        ]
      })
      {:ok, %Chargebeex.Invoice{}}
  """
  def create_for_charge_items_and_charges(params, opts \\ []) do
    generic_action_without_id(
      :post,
      @resource,
      "create_for_charge_items_and_charges",
      params,
      opts
    )
  end

  @doc """
  Allows to list Invoices

  Available filters can be found here: https://apidocs.chargebee.com/docs/api/invoices?lang=curl#list_invoices

  ## Examples

      iex> filters = %{limit: 2}
      iex(2)> Chargebeex.Invoice.list(filters)
      {:ok, [%Chargebeex.Invoice{...}, %Chargebeex.Invoice{...}], %{"next_offset" => nil}}
  """
  def list(params), do: super(params)
end
