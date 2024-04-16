defmodule Chargebeex.Subscription do
  use TypedStruct

  @resource "subscription"
  use Chargebeex.Resource, resource: @resource, only: [:list, :retrieve, :update]

  alias Chargebeex.Builder
  alias Chargebeex.Client

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
          id: "GHI456OPQ789",
          contract_term: %{},
          referral_info: %{},
          shipping_address: %{},
          coupons: nil,
          charged_items: nil,
          item_tiers: nil,
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
          business_entity_id: "ABC123XYZ456",
          auto_close_invoices: true,
          custom_fields: %{},
          metadata: %{},
          create_pending_invoices: false,
          free_period_unit: nil,
          free_period: nil,
          cancel_reason_code: nil,
          changes_scheduled_at: nil,
          deleted: false,
          invoice_notes: nil,
          base_currency_code: nil,
          exchange_rate: nil,
          mrr: nil,
          total_dues: nil,
          due_since: nil,
          due_invoices_count: 0,
          net_term_days: nil,
          channel: "web",
          cancel_schedule_created_at: nil,
          plan_amount_in_decimal: nil,
          plan_free_quantity_in_decimal: nil,
          payment_source_id: nil,
          has_scheduled_changes: false,
          has_scheduled_advance_invoices: false,
          updated_at: 1705785896,
          resource_version: 1705785896428,
          created_from_ip: nil,
          cancel_reason: nil,
          cancelled_at: nil,
          resume_date: nil,
          pause_date: nil,
          override_relationship: false,
          contract_term_billing_cycle_on_renewal: nil,
          activated_at: nil,
          started_at: 1705705200,
          created_at: 1705785896,
          next_billing_at: 1705878000,
          current_term_end: nil,
          current_term_start: nil,
          trial_end_action: nil,
          currency_code: nil,
          start_date: nil,
          trial_end: nil,
          billing_period: nil,
          billing_period_unit: nil,
          object: nil,
          remaining_billing_cycles: nil,
          po_number: nil,
          plan_quantity_in_decimal: nil,
          plan_unit_price_in_decimal: nil,
          customer_id: nil,
          status: nil,
          trial_start: nil
        }}
  """
  def create_with_items(customer_id, params, opts \\ []) do
    with path <-
           Chargebeex.Action.nested_resource_path_generic_without_id(
             [customer: customer_id],
             "subscription_for_items"
           ),
         {:ok, _status_code, _headers, content} <- Client.post(path, params, opts),
         builded <- Builder.build(content) do
      {:ok, Map.get(builded, @resource)}
    end
  end

  def update_for_items(subscription_id, params, opts \\ []) do
    Chargebeex.Action.generic_action(
      :post,
      @resource,
      "update_for_items",
      subscription_id,
      params,
      opts
    )
  end
end
