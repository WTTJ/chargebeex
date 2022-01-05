defmodule ChargebeeElixir.CustomerTest do
  use ExUnit.Case

  import Mox

  alias ChargebeeElixir.Fixtures.APIReturns
  alias ChargebeeElixir.Customer

  setup :verify_on_exit!

  describe "retrieve" do
    test "incorrect auth" do
      unauthorized = APIReturns.unauthorized()

      expect(
        ChargebeeElixir.HTTPClientMock,
        :get,
        fn _url, _body, _headers ->
          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = ChargebeeElixir.Customer.retrieve(1234)
    end

    test "not found" do
      not_found = APIReturns.not_found()

      expect(
        ChargebeeElixir.HTTPClientMock,
        :get,
        fn _url, _body, _headers ->
          {:ok, 404, [], Jason.encode!(not_found)}
        end
      )

      assert {:error, 404, [], ^not_found} = ChargebeeElixir.Customer.retrieve(1234)
    end

    test "found" do
      expect(
        ChargebeeElixir.HTTPClientMock,
        :get,
        fn _url, _body, _headers ->
          {:ok, 200, [], Jason.encode!(%{customer: %{id: 1234}})}
        end
      )

      assert {:ok, %Customer{id: 1234}} == ChargebeeElixir.Customer.retrieve(1234)
    end
  end
end
