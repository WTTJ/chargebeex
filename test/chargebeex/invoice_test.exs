defmodule Chargebeex.InvoiceTest do
  use ExUnit.Case, async: true

  import Hammox

  alias Chargebeex.Fixtures.Common
  alias Chargebeex.Invoice

  setup :verify_on_exit!

  describe "create_for_charge_items_and_charges" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/invoices/create_for_charge_items_and_charges"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert data == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = Invoice.create_for_charge_items_and_charges(%{})
    end

    test "with invalid data should fail" do
      bad_request = Common.bad_request()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/invoices/create_for_charge_items_and_charges"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert data == "invalid_attr=invalid"

          {:ok, 400, [], Jason.encode!(bad_request)}
        end
      )

      assert {:error, 400, [], ^bad_request} =
               Invoice.create_for_charge_items_and_charges(%{invalid_attr: "invalid"})
    end

    test "with valid data should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/invoices/create_for_charge_items_and_charges"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert data ==
                   "customer_id=__test__KyVkkWS1xLskm8&item_prices[item_price_id][0]=ssl-charge-USD&item_prices[unit_price][0]=2000"

          {:ok, 200, [],
           Jason.encode!(%{
             invoice: %{
               customer_id: "__test__KyVkkWS1xLskm8",
               item_prices: [
                 %{
                   item_price_id: "ssl-charge-USD",
                   unit_price: 2000
                 }
               ]
             }
           })}
        end
      )

      assert {:ok, %Invoice{}} =
               Invoice.create_for_charge_items_and_charges(%{
                 customer_id: "__test__KyVkkWS1xLskm8",
                 item_prices: [
                   %{
                     item_price_id: "ssl-charge-USD",
                     unit_price: 2000
                   }
                 ]
               })
    end
  end
end
