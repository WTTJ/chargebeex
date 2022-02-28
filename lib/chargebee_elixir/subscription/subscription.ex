defmodule Chargebeex.Subscription do
  defstruct [
    :activated_at,
    :billing_period,
    :billing_period_unit,
    :created_at,
    :currency_code,
    :current_term_end,
    :current_term_start,
    :customer_id,
    :deleted,
    :due_invoices_count,
    :due_since,
    :has_scheduled_changes,
    :id,
    :mrr,
    :next_billing_at,
    :object,
    :remaining_billing_cycles,
    :resource_version,
    :started_at,
    :status,
    :subscription_items,
    :total_dues,
    :updated_at,
    _raw_payload: %{}
  ]

  use Chargebeex.Resource, resource: "subscription", only: [:list, :retrieve, :update]

  def build(raw_data) do
    attrs = %{
      activated_at: raw_data["activated_at"],
      billing_period: raw_data["billing_period"],
      billing_period_unit: raw_data["billing_period_unit"],
      created_at: raw_data["created_at"],
      currency_code: raw_data["currency_code"],
      current_term_end: raw_data["current_term_end"],
      current_term_start: raw_data["current_term_start"],
      customer_id: raw_data["customer_id"],
      deleted: raw_data["deleted"],
      due_invoices_count: raw_data["due_invoices_count"],
      due_since: raw_data["due_since"],
      has_scheduled_changes: raw_data["has_scheduled_changes"],
      id: raw_data["id"],
      mrr: raw_data["mrr"],
      next_billing_at: raw_data["next_billing_at"],
      object: raw_data["object"],
      remaining_billing_cycles: raw_data["remaining_billing_cycles"],
      resource_version: raw_data["resource_version"],
      started_at: raw_data["started_at"],
      status: raw_data["status"],
      subscription_items: raw_data["subscription_items"],
      total_dues: raw_data["total_dues"],
      updated_at: raw_data["updated_at"],
      _raw_payload: raw_data
    }

    struct(__MODULE__, attrs)
  end
end
