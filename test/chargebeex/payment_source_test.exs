defmodule Chargebeex.PaymentSourceTest do
  use ExUnit.Case, async: true

  import Hammox

  alias Chargebeex.Fixtures.Common

  alias Chargebeex.PaymentSource

  setup :verify_on_exit!

  describe "retrieve" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/payment_sources/1234"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = PaymentSource.retrieve(1234)
    end

    test "with resource not found should fail" do
      not_found = Common.not_found()

      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/payment_sources/1234"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 404, [], Jason.encode!(not_found)}
        end
      )

      assert {:error, 404, [], ^not_found} = PaymentSource.retrieve(1234)
    end

    test "with resource found should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/payment_sources/1234"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 200, [], Jason.encode!(%{payment_source: %{}})}
        end
      )

      assert {:ok, %PaymentSource{}} = PaymentSource.retrieve(1234)
    end
  end

  describe "list" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/payment_sources"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = PaymentSource.list()
    end

    test "with no param, no offset should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/payment_sources"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 200, [],
           Jason.encode!(%{
             list: [%{payment_source: %{}}, %{payment_source: %{}}]
           })}
        end
      )

      assert {:ok, [%PaymentSource{}, %PaymentSource{}], %{"next_offset" => nil}} =
               PaymentSource.list()
    end

    test "with limit & offset params should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/payment_sources?limit=1"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          result = %{
            list: [%{payment_source: %{}}],
            next_offset: "foobar"
          }

          {:ok, 200, [], Jason.encode!(result)}
        end
      )

      assert {:ok, [%PaymentSource{}], %{"next_offset" => "foobar"}} =
               PaymentSource.list(%{limit: 1})
    end
  end

  describe "create_card" do
    test "given a customer_id and a card should build the payload and post the request" do
      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/payment_sources/create_card"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert URI.decode_query(body) ==
                   %{
                     "card[cvv]" => "100",
                     "card[expiry_month]" => "12",
                     "card[expiry_year]" => "2022",
                     "card[number]" => "378282246310005",
                     "customer_id" => "customer:42"
                   }

          {:ok, 200, [],
           Jason.encode!(%{
             payment_source: %{
               card: %{
                 expiry_month: 12,
                 expiry_year: 2022,
                 masked_number: "***********0005",
                 object: "card",
                 iin: "378282",
                 last4: "0005"
               },
               customer_id: "customer:42",
               status: "valid",
               type: "card"
             }
           })}
        end
      )

      assert {:ok, payment_source} =
               PaymentSource.create_card(%{
                 customer_id: "customer:42",
                 card: %{
                   number: "378282246310005",
                   cvv: "100",
                   expiry_year: 2022,
                   expiry_month: 12
                 }
               })

      assert %Chargebeex.PaymentSource{
               card: %Chargebeex.Card{
                 object: "card",
                 masked_number: "***********0005",
                 last4: "0005",
                 iin: "378282"
               },
               status: "valid",
               type: "card",
               customer_id: "customer:42"
             } = payment_source
    end
  end

  describe "create_bank_account" do
    test "given a customer_id and a bank_account should build the payload and post the request" do
      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/payment_sources/create_bank_account"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert URI.decode_query(body) ==
                   %{
                     "bank_account[account_holder_type]" => "INDIVIDUAL",
                     "bank_account[account_number]" => "000222222227",
                     "bank_account[account_type]" => "SAVINGS",
                     "bank_account[first_name]" => "Shay",
                     "bank_account[last_name]" => "Liam",
                     "bank_account[routing_number]" => "110000000",
                     "customer_id" => "customer:42"
                   }

          {:ok, 200, [],
           Jason.encode!(%{
             payment_source: %{
               bank_account: %{
                 account_holder_type: "individual",
                 account_type: "not_applicable",
                 bank_name: "US Bank",
                 last4: "2227",
                 name_on_account: "Shay Liam",
                 object: "bank_account"
               },
               customer_id: "customer:42",
               status: "valid",
               type: "direct_debit"
             }
           })}
        end
      )

      assert {:ok, payment_source} =
               PaymentSource.create_bank_account(%{
                 customer_id: "customer:42",
                 bank_account: %{
                   account_number: "000222222227",
                   routing_number: "110000000",
                   account_holder_type: "INDIVIDUAL",
                   account_type: "SAVINGS",
                   first_name: "Shay",
                   last_name: "Liam"
                 }
               })

      assert %Chargebeex.PaymentSource{
               bank_account: %Chargebeex.BankAccount{
                 account_holder_type: "individual",
                 bank_name: "US Bank",
                 name_on_account: "Shay Liam",
                 last4: "2227"
               },
               status: "valid",
               type: "direct_debit",
               customer_id: "customer:42"
             } = payment_source
    end
  end
end
