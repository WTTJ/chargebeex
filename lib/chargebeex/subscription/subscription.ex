defmodule Chargebeex.Subscription do
  use TypedStruct

  @resource "subscription"
  use Chargebeex.Resource, resource: @resource, only: [:list, :retrieve, :update, :delete]

  @typedoc """
  "future" | "in_trial" | "active" | "non_renewing" | "paused" | "cancelled"
  """
  @type status :: String.t()

  @typedoc """
  "site_default" | "plan_default" | "activate_subscription" | "cancel_subscription"
  """
  @type trial_end_action :: String.t()

  @typedoc """
  "not_paid" | "no_card" | "fraud_review_failed" | "non_compliant_eu_customer" | "tax_calculation_failed" | "currency_incompatible_with_gateway" | "non_compliant_customer"
  """
  @type cancel_reason :: String.t()

  @typedoc """
  "web" | "app_store" | "play_store"
  """
  @type channel :: String.t()

  @typedoc """
  "day" | "week" | "month" | "year"
  """
  @type period_unit :: String.t()

  typedstruct do
    field :id, String.t()
    field :currency_code, String.t()
    field :start_date, non_neg_integer()
    field :trial_end, non_neg_integer()
    field :billing_period, String.t()
    field :billing_period_unit, period_unit()
    field :object, String.t()
    field :remaining_billing_cycles, non_neg_integer()
    field :po_number, String.t()
    field :plan_quantity_in_decimal, String.t()
    field :plan_unit_price_in_decimal, String.t()
    field :customer_id, String.t()
    field :status, status()
    field :trial_start, String.t()
    field :trial_end_action, trial_end_action()
    field :current_term_start, non_neg_integer()
    field :current_term_end, non_neg_integer()
    field :next_billing_at, non_neg_integer()
    field :created_at, non_neg_integer()
    field :started_at, non_neg_integer()
    field :activated_at, non_neg_integer()
    field :contract_term_billing_cycle_on_renewal, non_neg_integer()
    field :override_relationship, boolean()
    field :pause_date, non_neg_integer()
    field :resume_date, non_neg_integer()
    field :cancelled_at, non_neg_integer()
    field :cancel_reason, cancel_reason()
    field :created_from_ip, String.t()
    field :resource_version, non_neg_integer()
    field :updated_at, non_neg_integer()
    field :has_scheduled_advance_invoices, boolean()
    field :has_scheduled_changes, boolean()
    field :payment_source_id, String.t()
    field :plan_free_quantity_in_decimal, String.t()
    field :plan_amount_in_decimal, String.t()
    field :cancel_schedule_created_at, non_neg_integer()
    field :channel, channel()
    field :net_term_days, non_neg_integer()
    field :due_invoices_count, integer()
    field :due_since, non_neg_integer()
    field :total_dues, non_neg_integer()
    field :mrr, non_neg_integer()
    field :exchange_rate, float()
    field :base_currency_code, String.t()
    field :invoice_notes, String.t()
    field :deleted, boolean()
    field :changes_scheduled_at, non_neg_integer()
    field :cancel_reason_code, String.t()
    field :free_period, integer()
    field :free_period_unit, period_unit()
    field :create_pending_invoices, boolean()
    field :metadata, map(), default: %{}
    field :custom_fields, map(), default: %{}
    field :auto_close_invoices, boolean()
    field :business_entity_id, String.t()
    field :subscription_items, list()
    field :item_tiers, list()
    field :charged_items, list()
    field :coupons, list()
    field :shipping_address, map(), default: %{}
    field :referral_info, map(), default: %{}
    field :contract_term, map(), default: %{}
  end

  use ExConstructor, :build

  def build(raw_data) do
    raw_data
    |> super()
    |> Chargebeex.Resource.add_custom_fields(raw_data)
  end

  @doc """
  Creates a Subcription with items for a Customer

  ## Examples

      iex> Chargebeex.Subscription.create_with_items("169ljDT1Op0yuxET", %{
                 subscription_items: [
                   %{
                     item_price_id: "DEF789LMN012",
                     quantity: 1
                   }
                 ]
               })
      {:ok, %Chargebeex.Subscription{
          subscription_items: [
            %{
              "amount" => 100,
              "free_quantity" => 0,
              "item_price_id" => "DEF789LMN012",
              "item_type" => "plan",
              "object" => "subscription_item",
              "quantity" => 1,
              "trial_end" => 1705877999,
              "unit_price" => 100
            }
          ],
          customer_id: "169ljDT1Op0yuxET",
          ...
        }}
  """
  def create_with_items(customer_id, params, opts \\ []) do
    nested_generic_action_without_id(
      :post,
      [customer: customer_id],
      @resource,
      "subscription_for_items",
      params,
      opts
    )
  end

  def update_for_items(subscription_id, params, opts \\ []) do
    generic_action(
      :post,
      @resource,
      "update_for_items",
      subscription_id,
      params,
      opts
    )
  end
end
