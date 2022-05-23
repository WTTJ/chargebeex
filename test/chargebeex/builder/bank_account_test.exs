defmodule Chargebeex.Builder.BankAccountTest do
  use ExUnit.Case, async: true

  alias Chargebeex.Builder
  alias Chargebeex.Fixtures.BankAccount, as: BankAccountFixture
  alias Chargebeex.BankAccount

  describe "build/1" do
    test "should build a bank account" do
      builded =
        BankAccountFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()

      assert %{"bank_account" => %BankAccount{}} = builded
    end

    test "should have card params" do
      bank_account =
        BankAccountFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()
        |> Map.get("bank_account")

      params = BankAccountFixture.bank_account_params() |> Jason.decode!()

      assert bank_account.last4 == Map.get(params, "last4")
      assert bank_account.name_on_account == Map.get(params, "name_on_account")
      assert bank_account.first_name == Map.get(params, "first_name")
      assert bank_account.last_name == Map.get(params, "last_name")
      assert bank_account.bank_name == Map.get(params, "bank_name")
      assert bank_account.mandate_id == Map.get(params, "mandate_id")
      assert bank_account.account_type == Map.get(params, "account_type")
      assert bank_account.echeck_type == Map.get(params, "echeck_type")
      assert bank_account.account_holder_type == Map.get(params, "account_holder_type")
      assert bank_account.email == Map.get(params, "email")
    end
  end
end
