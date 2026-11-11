defmodule Chargebeex.InvoiceTest do
  use ExUnit.Case, async: true

  import Hammox

  alias Chargebeex.Fixtures.Common
  alias Chargebeex.Fixtures.Invoice, as: InvoiceFixture
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

  describe "pdf" do
    @pdf_url "https://test-namespace.chargebee.com/api/v2/invoices/inv_x/pdf"
    @post_headers [
      {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
      {"Content-Type", "application/x-www-form-urlencoded"}
    ]

    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(Chargebeex.HTTPClientMock, :post, fn url, data, headers ->
        assert url == @pdf_url
        assert headers == @post_headers
        assert data == ""

        {:ok, 401, [], Jason.encode!(unauthorized)}
      end)

      assert {:error, 401, [], ^unauthorized} = Invoice.pdf("inv_x")
    end

    test "with unknown invoice should fail" do
      not_found = Common.not_found()

      expect(Chargebeex.HTTPClientMock, :post, fn url, _data, _headers ->
        assert url == @pdf_url

        {:ok, 404, [], Jason.encode!(not_found)}
      end)

      assert {:error, 404, [], ^not_found} = Invoice.pdf("inv_x")
    end

    test "with disposition_type should return the download map" do
      expect(Chargebeex.HTTPClientMock, :post, fn url, data, headers ->
        assert url == @pdf_url
        assert headers == @post_headers
        assert data == "disposition_type=inline"

        {:ok, 200, [], InvoiceFixture.pdf_download()}
      end)

      assert {:ok, download} = Invoice.pdf("inv_x", %{disposition_type: "inline"})

      assert %{
               "download_url" => url,
               "valid_till" => valid_till,
               "mime_type" => "application/pdf",
               "object" => "download"
             } = download

      assert is_binary(url)
      assert is_integer(valid_till)
      refute is_struct(download)
    end

    test "without params should send an empty body" do
      expect(Chargebeex.HTTPClientMock, :post, fn url, data, _headers ->
        assert url == @pdf_url
        assert data == ""

        {:ok, 200, [], InvoiceFixture.pdf_download()}
      end)

      assert {:ok, %{"download_url" => _}} = Invoice.pdf("inv_x")
    end

    test "with a success response missing the download object should fail" do
      expect(Chargebeex.HTTPClientMock, :post, fn _url, _data, _headers ->
        {:ok, 200, [], Jason.encode!(%{invoice: %{id: "inv_x"}})}
      end)

      assert {:error, :invalid_response} = Invoice.pdf("inv_x")
    end
  end
end
