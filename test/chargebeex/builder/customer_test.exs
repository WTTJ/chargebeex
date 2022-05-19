defmodule Chargebeex.Builder.CustomerTest do
  use ExUnit.Case, async: true

  alias Chargebeex.Builder
  alias Chargebeex.Customer
  alias Chargebeex.Fixtures.Customer, as: CustomerFixture

  describe "build/1" do
    test "should build an customer" do
      builded =
        CustomerFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()

      assert %{"customer" => %Customer{}} = builded
    end

    test "should build a list of customers" do
      builded =
        CustomerFixture.list()
        |> Jason.decode!()
        |> Builder.build()

      assert {[
                %{"customer" => %Customer{}},
                %{"customer" => %Customer{}}
              ], %{"next_offset" => _}} = builded
    end

    test "should have customer params" do
      customer =
        CustomerFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()
        |> Map.get("customer")

      params = CustomerFixture.customer_params() |> Jason.decode!()

      assert customer.allow_direct_debit == Map.get(params, "allow_direct_debit")
      assert customer.auto_collection == Map.get(params, "auto_collection")
      assert customer.card_status == Map.get(params, "card_status")
      assert customer.created_at == Map.get(params, "created_at")
      assert customer.deleted == Map.get(params, "deleted")
      assert customer.excess_payments == Map.get(params, "excess_payments")
      assert customer.first_name == Map.get(params, "first_name")
      assert customer.id == Map.get(params, "id")
      assert customer.last_name == Map.get(params, "last_name")
      assert customer.net_term_days == Map.get(params, "net_term_days")
      assert customer.object == Map.get(params, "object")
      assert customer.pii_cleared == Map.get(params, "pii_cleared")
      assert customer.preferred_currency_code == Map.get(params, "preferred_currency_code")
      assert customer.promotional_credits == Map.get(params, "promotional_credits")
      assert customer.refundable_credits == Map.get(params, "refundable_credits")
      assert customer.resource_version == Map.get(params, "resource_version")
      assert customer.taxability == Map.get(params, "taxability")
      assert customer.unbilled_charges == Map.get(params, "unbilled_charges")
      assert customer.updated_at == Map.get(params, "updated_at")
      assert customer.vat_number == Map.get(params, "vat_number")
      assert customer.vat_number_validated_time == Map.get(params, "vat_number_validated_time")
      assert customer.vat_number_status == Map.get(params, "vat_number_status")
      assert customer.primary_payment_source_id == Map.get(params, "primary_payment_source_id")
      assert customer.backup_payment_source_id == Map.get(params, "backup_payment_source_id")
    end
  end
end
