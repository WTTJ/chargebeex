defmodule Chargebeex.Subscription do
  defstruct [
    :id,
    :currency_code,
    :start_date,
    :trial_end,
    :billing_period,
    :billing_period_unit,
    :object,
    :remaining_billing_cycles,
    :po_number,
    :plan_quantity_in_decimal,
    :plan_unit_price_in_decimal,
    :customer_id,
    :status,
    :trial_start,
    :trial_end_action,
    :current_term_start,
    :current_term_end,
    :next_billing_at,
    :created_at,
    :started_at,
    :activated_at,
    :contract_term_billing_cycle_on_renewal,
    :override_relationship,
    :pause_date,
    :resume_date,
    :cancelled_at,
    :cancel_reason,
    :created_from_ip,
    :resource_version,
    :updated_at,
    :payment_source_id,
    :plan_free_quantity_in_decimal,
    :plan_amount_in_decimal,
    :cancel_schedule_created_at,
    :channel,
    :net_term_days,
    :due_invoices_count,
    :due_since,
    :total_dues,
    :mrr,
    :exchange_rate,
    :base_currency_code,
    :invoice_notes,
    :deleted,
    :changes_scheduled_at,
    :cancel_reason_code,
    :free_period,
    :free_period_unit,
    :create_pending_invoices,
    :auto_close_invoices,
    :business_entity_id,
    has_scheduled_advance_invoices: false,
    has_scheduled_changes: false,
    metadata: %{},
    custom_fields: %{},
    subscription_items: [],
    item_tiers: [],
    charged_items: [],
    coupons: [],
    shipping_address: %{},
    referral_info: %{},
    contract_term: %{}
  ]

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

  @type t :: %__MODULE__{
          id: binary(),
          currency_code: binary() | nil,
          start_date: non_neg_integer() | nil,
          trial_end: non_neg_integer() | nil,
          billing_period: binary() | nil,
          billing_period_unit: period_unit() | nil,
          object: binary() | nil,
          remaining_billing_cycles: non_neg_integer() | nil,
          po_number: binary() | nil,
          plan_quantity_in_decimal: binary() | nil,
          plan_unit_price_in_decimal: binary() | nil,
          customer_id: binary(),
          status: status(),
          trial_start: binary() | nil,
          trial_end_action: trial_end_action() | nil,
          current_term_start: non_neg_integer() | nil,
          current_term_end: non_neg_integer() | nil,
          next_billing_at: non_neg_integer() | nil,
          created_at: non_neg_integer() | nil,
          started_at: non_neg_integer() | nil,
          activated_at: non_neg_integer() | nil,
          contract_term_billing_cycle_on_renewal: non_neg_integer() | nil,
          override_relationship: boolean() | nil,
          pause_date: non_neg_integer() | nil,
          resume_date: non_neg_integer() | nil,
          cancelled_at: non_neg_integer() | nil,
          cancel_reason: cancel_reason() | nil,
          created_from_ip: binary() | nil,
          resource_version: non_neg_integer() | nil,
          updated_at: non_neg_integer() | nil,
          has_scheduled_advance_invoices: boolean(),
          has_scheduled_changes: boolean(),
          payment_source_id: binary() | nil,
          plan_free_quantity_in_decimal: binary() | nil,
          plan_amount_in_decimal: binary() | nil,
          cancel_schedule_created_at: non_neg_integer() | nil,
          channel: channel() | nil,
          net_term_days: integer() | nil,
          due_invoices_count: integer() | nil,
          due_since: non_neg_integer() | nil,
          total_dues: non_neg_integer() | nil,
          mrr: non_neg_integer() | nil,
          exchange_rate: float() | nil,
          base_currency_code: binary() | nil,
          invoice_notes: binary() | nil,
          metadata: %{},
          custom_fields: %{},
          deleted: boolean(),
          changes_scheduled_at: non_neg_integer() | nil,
          cancel_reason_code: binary() | nil,
          free_period: integer() | nil,
          free_period_unit: period_unit() | nil,
          create_pending_invoices: boolean() | nil,
          auto_close_invoices: boolean() | nil,
          business_entity_id: binary() | nil,
          subscription_items: [%{}],
          item_tiers: [%{}],
          charged_items: [%{}],
          coupons: [%{}],
          shipping_address: %{},
          referral_info: %{},
          contract_term: %{}
        }

  use Chargebeex.Resource, resource: "subscription", only: [:list, :retrieve, :update]

  def build(raw_data) do
    attrs =
      %{
        id: Map.get(raw_data, "id"),
        currency_code: Map.get(raw_data, "currency_code"),
        start_date: Map.get(raw_data, "start_date"),
        trial_end: Map.get(raw_data, "trial_end"),
        billing_period: Map.get(raw_data, "billing_period"),
        object: Map.get(raw_data, "object"),
        billing_period_unit: Map.get(raw_data, "billing_period_unit"),
        remaining_billing_cycles: Map.get(raw_data, "remaining_billing_cycles"),
        po_number: Map.get(raw_data, "po_number"),
        plan_quantity_in_decimal: Map.get(raw_data, "plan_quantity_in_decimal"),
        plan_unit_price_in_decimal: Map.get(raw_data, "plan_unit_price_in_decimal"),
        customer_id: Map.get(raw_data, "customer_id"),
        status: Map.get(raw_data, "status"),
        trial_start: Map.get(raw_data, "trial_start"),
        trial_end_action: Map.get(raw_data, "trial_end_action"),
        current_term_start: Map.get(raw_data, "current_term_start"),
        current_term_end: Map.get(raw_data, "current_term_end"),
        next_billing_at: Map.get(raw_data, "next_billing_at"),
        created_at: Map.get(raw_data, "created_at"),
        started_at: Map.get(raw_data, "started_at"),
        activated_at: Map.get(raw_data, "activated_at"),
        contract_term_billing_cycle_on_renewal:
          Map.get(raw_data, "contract_term_billing_cycle_on_renewal"),
        override_relationship: Map.get(raw_data, "override_relationship"),
        pause_date: Map.get(raw_data, "pause_date"),
        resume_date: Map.get(raw_data, "resume_date"),
        cancelled_at: Map.get(raw_data, "cancelled_at"),
        cancel_reason: Map.get(raw_data, "cancel_reason"),
        created_from_ip: Map.get(raw_data, "created_from_ip"),
        resource_version: Map.get(raw_data, "resource_version"),
        updated_at: Map.get(raw_data, "updated_at"),
        payment_source_id: Map.get(raw_data, "payment_source_id"),
        plan_free_quantity_in_decimal: Map.get(raw_data, "plan_free_quantity_in_decimalz"),
        plan_amount_in_decimal: Map.get(raw_data, "plan_amount_in_decimal"),
        cancel_schedule_created_at: Map.get(raw_data, "cancel_schedule_created_at"),
        channel: Map.get(raw_data, "channel"),
        net_term_days: Map.get(raw_data, "net_term_days"),
        due_invoices_count: Map.get(raw_data, "due_invoices_count"),
        due_since: Map.get(raw_data, "due_since"),
        total_dues: Map.get(raw_data, "total_dues"),
        mrr: Map.get(raw_data, "mrr"),
        exchange_rate: Map.get(raw_data, "exchange_rate"),
        base_currency_code: Map.get(raw_data, "base_currency_code"),
        invoice_notes: Map.get(raw_data, "invoice_notes"),
        deleted: Map.get(raw_data, "deleted"),
        changes_scheduled_at: Map.get(raw_data, "changes_scheduled_at"),
        cancel_reason_code: Map.get(raw_data, "cancel_reason_code"),
        free_period: Map.get(raw_data, "free_period"),
        free_period_unit: Map.get(raw_data, "free_period_unit"),
        create_pending_invoices: Map.get(raw_data, "create_pending_invoices"),
        auto_close_invoices: Map.get(raw_data, "auto_close_invoices"),
        business_entity_id: Map.get(raw_data, "business_entity_id"),
        has_scheduled_advance_invoices: Map.get(raw_data, "has_scheduled_advance_invoices"),
        has_scheduled_changes: Map.get(raw_data, "has_scheduled_changes"),
        metadata: Map.get(raw_data, "metadata"),
        subscription_items: Map.get(raw_data, "subscription_items"),
        item_tiers: Map.get(raw_data, "item_tiers"),
        charged_items: Map.get(raw_data, "charged_items"),
        coupons: Map.get(raw_data, "coupons"),
        shipping_address: Map.get(raw_data, "shipping_address"),
        referral_info: Map.get(raw_data, "referral_info"),
        contract_term: Map.get(raw_data, "contract_term")
      }
      |> Chargebeex.Resource.add_custom_fields(raw_data)

    struct(__MODULE__, attrs)
  end
end
