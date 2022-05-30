defmodule Chargebeex.Builder.InvoiceTest do
  use ExUnit.Case, async: true

  alias Chargebeex.Builder
  alias Chargebeex.Fixtures.Invoice, as: InvoiceFixture
  alias Chargebeex.Invoice

  describe "build/1" do
    test "should build a invoice" do
      builded =
        InvoiceFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()

      assert %{"invoice" => %Invoice{}} = builded
    end

    test "should have invoice params" do
      invoice =
        InvoiceFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()
        |> Map.get("invoice")

      params = InvoiceFixture.invoice_params() |> Jason.decode!()

      assert invoice.adjustment_credit_notes == Map.get(params, "adjustment_credit_notes")
      assert invoice.amount_adjusted == Map.get(params, "amount_adjusted")
      assert invoice.amount_due == Map.get(params, "amount_due")
      assert invoice.amount_paid == Map.get(params, "amount_paid")
      assert invoice.amount_to_collect == Map.get(params, "amount_to_collect")
      assert invoice.applied_credits == Map.get(params, "applied_credits")
      assert invoice.base_currency_code == Map.get(params, "base_currency_code")
      assert invoice.billing_address == Map.get(params, "billing_address")
      assert invoice.credits_applied == Map.get(params, "credits_applied")
      assert invoice.currency_code == Map.get(params, "currency_code")
      assert invoice.customer_id == Map.get(params, "customer_id")
      assert invoice.date == Map.get(params, "date")
      assert invoice.deleted == Map.get(params, "deleted")
      assert invoice.due_date == Map.get(params, "due_date")
      assert invoice.dunning_attempts == Map.get(params, "dunning_attempts")
      assert invoice.exchange_rate == Map.get(params, "exchange_rate")
      assert invoice.first_invoice == Map.get(params, "first_invoice")
      assert invoice.has_advance_charges == Map.get(params, "has_advance_charges")
      assert invoice.id == Map.get(params, "id")
      assert invoice.is_gifted == Map.get(params, "is_gifted")
      assert invoice.issued_credit_notes == Map.get(params, "issued_credit_notes")
      assert invoice.line_items == Map.get(params, "line_items")
      assert invoice.linked_orders == Map.get(params, "linked_orders")
      assert invoice.linked_payments == Map.get(params, "linked_payments")
      assert invoice.net_term_days == Map.get(params, "net_term_days")
      assert invoice.new_sales_amount == Map.get(params, "new_sales_amount")
      assert invoice.object == Map.get(params, "object")
      assert invoice.paid_at == Map.get(params, "paid_at")
      assert invoice.price_type == Map.get(params, "price_type")
      assert invoice.recurring == Map.get(params, "recurring")
      assert invoice.resource_version == Map.get(params, "resource_version")
      assert invoice.round_off_amount == Map.get(params, "round_off_amount")
      assert invoice.status == Map.get(params, "status")
      assert invoice.sub_total == Map.get(params, "sub_total")
      assert invoice.subscription_id == Map.get(params, "subscription_id")
      assert invoice.tax == Map.get(params, "tax")
      assert invoice.term_finalized == Map.get(params, "term_finalized")
      assert invoice.total == Map.get(params, "total")
      assert invoice.updated_at == Map.get(params, "updated_at")
      assert invoice.write_off_amount == Map.get(params, "write_off_amount")
    end
  end
end
