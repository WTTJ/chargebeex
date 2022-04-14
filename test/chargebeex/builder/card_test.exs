defmodule Chargebeex.Builder.CardTest do
  use ExUnit.Case, async: true

  alias Chargebeex.Builder
  alias Chargebeex.Fixtures.Card, as: CardFixture
  alias Chargebeex.Card

  describe "build/1" do
    test "should build a card" do
      builded =
        CardFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()

      assert %{"card" => %Card{}} = builded
    end

    test "should have card params" do
      card =
        CardFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()
        |> Map.get("card")

      params = CardFixture.card_params() |> Jason.decode!()

      assert card.card_type == Map.get(params, "card_type")
      assert card.created_at == Map.get(params, "created_at")
      assert card.customer_id == Map.get(params, "customer_id")
      assert card.expiry_month == Map.get(params, "expiry_month")
      assert card.expiry_year == Map.get(params, "expiry_year")
      assert card.funding_type == Map.get(params, "funding_type")
      assert card.gateway == Map.get(params, "gateway")
      assert card.gateway_account_id == Map.get(params, "gateway_account_id")
      assert card.iin == Map.get(params, "iin")
      assert card.last4 == Map.get(params, "last4")
      assert card.masked_number == Map.get(params, "masked_number")
      assert card.object == Map.get(params, "object")
      assert card.payment_source_id == Map.get(params, "payment_source_id")
      assert card.resource_version == Map.get(params, "resource_version")
      assert card.status == Map.get(params, "status")
      assert card.updated_at == Map.get(params, "updated_at")
    end
  end
end
