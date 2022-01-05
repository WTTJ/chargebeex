defmodule ChargebeeElixir.Fixtures.Event do
  def customer_updated(params \\ %{}) do
    %{
      event: %{
        api_version: "v2",
        content: %{
          customer: %{
            allow_direct_debit: false,
            auto_collection: "on",
            card_status: "no_card",
            created_at: 1_517_505_957,
            deleted: false,
            excess_payments: 0,
            id: "__test__KyVnHhSBWm4Xv2rm",
            net_term_days: 0,
            object: "customer",
            pii_cleared: "active",
            preferred_currency_code: "USD",
            promotional_credits: 0,
            refundable_credits: 0,
            resource_version: 1_517_505_957_000,
            taxability: "taxable",
            unbilled_charges: 0,
            updated_at: 1_517_505_957
          },
          subscription: %{
            billing_period: 1,
            billing_period_unit: "month",
            created_at: 1_517_505_957,
            currency_code: "USD",
            customer_id: "__test__KyVnHhSBWm4Xv2rm",
            deleted: false,
            due_invoices_count: 0,
            has_scheduled_changes: false,
            id: "__test__KyVnHhSBWm4Xv2rm",
            next_billing_at: 1_518_801_957,
            object: "subscription",
            plan_amount: 1500,
            plan_free_quantity: 0,
            plan_id: "plan1",
            plan_quantity: 1,
            plan_unit_price: 1500,
            resource_version: 1_517_505_957_000,
            started_at: 1_517_505_957,
            status: "in_trial",
            trial_end: 1_518_801_957,
            trial_start: 1_517_505_957,
            updated_at: 1_517_505_957
          }
        },
        event_type: "subscription_created",
        id: "ev___test__KyVnHhSBWm4am2rp",
        object: "event",
        occurred_at: 1_517_505_957,
        source: "api",
        user: "full_access_key_v1",
        webhook_status: "scheduled"
      }
    }
    |> Map.merge(params)
  end
end
