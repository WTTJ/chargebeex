defmodule ChargebeeElixir.CustomerTest do
  use ExUnit.Case

  import Mox

  alias ChargebeeElixir.Fixtures.APIReturns
  alias ChargebeeElixir.Customer

  setup :verify_on_exit!

  describe "retrieve" do
    test "with bad authentication should fail" do
      unauthorized = APIReturns.unauthorized()

      expect(
        ChargebeeElixir.HTTPClientMock,
        :get,
        fn _url, _body, _headers ->
          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = Customer.retrieve(1234)
    end

    test "with resource not found should fail" do
      not_found = APIReturns.not_found()

      expect(
        ChargebeeElixir.HTTPClientMock,
        :get,
        fn _url, _body, _headers ->
          {:ok, 404, [], Jason.encode!(not_found)}
        end
      )

      assert {:error, 404, [], ^not_found} = Customer.retrieve(1234)
    end

    test "with resource found should succeed" do
      expect(
        ChargebeeElixir.HTTPClientMock,
        :get,
        fn _url, _body, _headers ->
          {:ok, 200, [], Jason.encode!(%{customer: %{id: 1234}})}
        end
      )

      assert {:ok, %Customer{id: 1234}} == Customer.retrieve(1234)
    end
  end

  describe "list" do
    test "with bad authentication should fail" do
      unauthorized = APIReturns.unauthorized()

      expect(
        ChargebeeElixir.HTTPClientMock,
        :get,
        fn _url, _body, _headers ->
          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = Customer.list()
    end

    test "with no param, no offset should succeed" do
      expect(
        ChargebeeElixir.HTTPClientMock,
        :get,
        fn _url, _body, _headers ->
          {:ok, 200, [],
           Jason.encode!(%{list: [%{customer: %{id: 0000}}, %{customer: %{id: 9999}}]})}
        end
      )

      assert {:ok, [%Customer{id: 0000}, %Customer{id: 9999}], %{"next_offset" => nil}} =
               Customer.list()
    end

    test "with limit & offset params should succeed" do
      expect(
        ChargebeeElixir.HTTPClientMock,
        :get,
        fn _url, _body, _headers ->
          result = %{
            list: [%{customer: %{id: 0000}}],
            next_offset: "foobar"
          }

          {:ok, 200, [], Jason.encode!(result)}
        end
      )

      assert {:ok, [%Customer{id: 0000}], %{"next_offset" => "foobar"}} =
               Customer.list(%{limit: 1})
    end
  end

  describe "create" do
    test "with bad authentication should fail" do
      unauthorized = APIReturns.unauthorized()

      expect(
        ChargebeeElixir.HTTPClientMock,
        :post,
        fn _url, _data, _headers ->
          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = Customer.create(%{})
    end

    test "with invalid data should fail" do
      bad_request = APIReturns.bad_request()

      expect(
        ChargebeeElixir.HTTPClientMock,
        :post,
        fn _url, _data, _headers ->
          {:ok, 400, [], Jason.encode!(bad_request)}
        end
      )

      assert {:error, 400, [], ^bad_request} = Customer.create(%{})
    end

    test "with valid data should succeed" do
      expect(
        ChargebeeElixir.HTTPClientMock,
        :post,
        fn _url, _data, _headers ->
          {:ok, 200, [], Jason.encode!(%{customer: %{id: "foobar"}})}
        end
      )

      assert {:ok, %Customer{id: "foobar"}} = ChargebeeElixir.Customer.create(%{})
    end
  end

  describe "update" do
    test "with bad authentication should fail" do
      unauthorized = APIReturns.unauthorized()

      expect(
        ChargebeeElixir.HTTPClientMock,
        :post,
        fn _url, _data, _headers ->
          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = Customer.update("foobar", %{})
    end

    test "with invalid data should fail" do
      bad_request = APIReturns.bad_request()

      expect(
        ChargebeeElixir.HTTPClientMock,
        :post,
        fn _url, _data, _headers ->
          {:ok, 400, [], Jason.encode!(bad_request)}
        end
      )

      assert {:error, 400, [], ^bad_request} = Customer.update("foobar", %{})
    end

    test "with valid data should succeed" do
      expect(
        ChargebeeElixir.HTTPClientMock,
        :post,
        fn _url, _data, _headers ->
          {:ok, 200, [], Jason.encode!(%{customer: %{id: "foobar"}})}
        end
      )

      assert {:ok, %Customer{id: "foobar"}} =
               ChargebeeElixir.Customer.update("foobar", %{email: "foobar@comany.com"})
    end
  end
end
