defmodule Chargebeex.Builder.QuoteTest do
  use ExUnit.Case, async: true

  alias Chargebeex.Builder
  alias Chargebeex.Fixtures.Quote, as: QuoteFixture
  alias Chargebeex.Quote

  describe "build/1" do
    test "should build a quote" do
      builded =
        QuoteFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()

      assert %{"quote" => %Quote{}} = builded
    end

    test "should have the quote params" do
      builded_quote =
        QuoteFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()
        |> Map.get("quote")

      params = QuoteFixture.quote_params() |> Jason.decode!()

      assert builded_quote.id == Map.get(params, "id")
      assert builded_quote.amount_due == Map.get(params, "amount_due")
      assert builded_quote.amount_paid == Map.get(params, "amount_paid")
      assert builded_quote.billing_address == Map.get(params, "billing_address")
      assert builded_quote.business_entity_id == Map.get(params, "business_entity_id")
      assert builded_quote.charge_on_acceptance == Map.get(params, "charge_on_acceptance")
      assert builded_quote.contract_term_end == Map.get(params, "contract_term_end")
      assert builded_quote.contract_term_start == Map.get(params, "contract_term_start")

      assert builded_quote.contract_term_termination_fee ==
               Map.get(params, "contract_term_termination_fee")

      assert builded_quote.credits_applied == Map.get(params, "credits_applied")
      assert builded_quote.currency_code == Map.get(params, "currency_code")
      assert builded_quote.customer_id == Map.get(params, "customer_id")
      assert builded_quote.date == Map.get(params, "date")
      assert builded_quote.discounts == Map.get(params, "discounts")
      assert builded_quote.invoice_id == Map.get(params, "invoice_id")
      assert builded_quote.line_item_discounts == Map.get(params, "line_item_discounts")
      assert builded_quote.line_item_taxes == Map.get(params, "line_item_taxes")
      assert builded_quote.line_item_tiers == Map.get(params, "line_item_tiers")
      assert builded_quote.line_items == Map.get(params, "line_items")
      assert builded_quote.name == Map.get(params, "name")
      assert builded_quote.notes == Map.get(params, "notes")
      assert builded_quote.operation_type == Map.get(params, "operation_type")
      assert builded_quote.po_number == Map.get(params, "po_number")
      assert builded_quote.price_type == Map.get(params, "price_type")
      assert builded_quote.resource_version == Map.get(params, "resource_version")
      assert builded_quote.shipping_address == Map.get(params, "shipping_address")
      assert builded_quote.status == Map.get(params, "status")
      assert builded_quote.sub_total == Map.get(params, "sub_total")
      assert builded_quote.subscription_id == Map.get(params, "subscription_id")
      assert builded_quote.taxes == Map.get(params, "taxes")
      assert builded_quote.total == Map.get(params, "total")
      assert builded_quote.total_payable == Map.get(params, "total_payable")
      assert builded_quote.updated_at == Map.get(params, "updated_at")
      assert builded_quote.valid_till == Map.get(params, "valid_till")
      assert builded_quote.vat_number == Map.get(params, "vat_number")
      assert builded_quote.vat_number_prefix == Map.get(params, "vat_number_prefix")
      assert builded_quote.version == Map.get(params, "version")
    end
  end
end
