defmodule Chargebeex.Builder.PaymentSourceTest do
  use ExUnit.Case, async: true

  alias Chargebeex.Builder
  alias Chargebeex.{BankAccount, Card}
  alias Chargebeex.Fixtures.PaymentSource, as: PaymentSourceFixture
  alias Chargebeex.PaymentSource

  describe "build/1" do
    test "should build an payment source" do
      builded =
        PaymentSourceFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()

      assert %{"payment_source" => %PaymentSource{}} = builded
    end

    test "should build a list of payment sources" do
      builded =
        PaymentSourceFixture.list()
        |> Jason.decode!()
        |> Builder.build()

      assert {[
                %{"payment_source" => %PaymentSource{}},
                %{"payment_source" => %PaymentSource{}}
              ], %{"next_offset" => _}} = builded
    end

    test "should have payment_source params" do
      payment_source =
        PaymentSourceFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()
        |> Map.get("payment_source")

      params = PaymentSourceFixture.payment_source_params() |> Jason.decode!()

      assert payment_source.id == Map.get(params, "id")
      assert payment_source.resource_version == Map.get(params, "resource_version")
      assert payment_source.updated_at == Map.get(params, "updated_at")
      assert payment_source.created_at == Map.get(params, "created_at")
      assert payment_source.type == Map.get(params, "type")
      assert payment_source.reference_id == Map.get(params, "reference_id")
      assert payment_source.status == Map.get(params, "status")
      assert payment_source.gateway == Map.get(params, "gateway")
      assert payment_source.gateway_account_id == Map.get(params, "gateway_account_id")
      assert payment_source.ip_address == Map.get(params, "ip_address")
      assert payment_source.issuing_country == Map.get(params, "issuing_country")
      assert payment_source.deleted == Map.get(params, "deleted")
      assert payment_source.business_entity_id == Map.get(params, "business_entity_id")
      assert payment_source.customer_id == Map.get(params, "customer_id")

      assert %Card{} = payment_source.card
      assert %BankAccount{} = payment_source.bank_account
    end
  end
end
