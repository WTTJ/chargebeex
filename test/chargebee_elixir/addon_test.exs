defmodule ChargebeeElixir.AddonTest do
  use ExUnit.Case

  import Mox

  alias ChargebeeElixir.Fixtures.APIReturns
  alias ChargebeeElixir.Addon

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

      assert {:error, 401, [], ^unauthorized} = ChargebeeElixir.Addon.retrieve(1234)
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

      assert {:error, 404, [], ^not_found} = ChargebeeElixir.Addon.retrieve(1234)
    end

    test "found" do
      expect(
        ChargebeeElixir.HTTPClientMock,
        :get,
        fn _url, _body, _headers ->
          {:ok, 200, [], Jason.encode!(%{addon: %{id: 1234}})}
        end
      )

      assert {:ok, %Addon{id: 1234}} == ChargebeeElixir.Addon.retrieve(1234)
    end
  end

  describe "list" do
    test "incorrect auth" do
      unauthorized = APIReturns.unauthorized()

      expect(
        ChargebeeElixir.HTTPClientMock,
        :get,
        fn _url, _body, _headers ->
          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = ChargebeeElixir.Addon.list()
    end

    test "no param, no offset" do
      expect(
        ChargebeeElixir.HTTPClientMock,
        :get,
        fn _url, _body, _headers ->
          {:ok, 200, [], Jason.encode!(%{list: [%{addon: %{id: 0000}}, %{addon: %{id: 9999}}]})}
        end
      )

      assert {:ok, [%Addon{id: 0000}, %Addon{id: 9999}], %{"next_offset" => nil}} =
               ChargebeeElixir.Addon.list()
    end

    @tag :skip
    test "headers, offset" do
      expect(
        ChargebeeElixir.HTTPClientMock,
        :get,
        fn url, "", headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/addons?id%5Bin%5D=%5B1234%2C1235%5D"

          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]

          %{
            status_code: 200,
            body: '{
              "list": [{"addon": {"id": 1234}}],
              "next_offset": 1235
              }'
          }
        end
      )

      expect(
        ChargebeeElixir.HTTPClientMock,
        :get,
        fn url, "", headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/addons?id%5Bin%5D=%5B1234%2C1235%5D&offset=1235"

          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]

          %{
            status_code: 200,
            body: '{
              "list": [{"addon": {"id": 1235}}]
              }'
          }
        end
      )

      assert ChargebeeElixir.Addon.list(%{"id[in]": "[1234,1235]"}) == [
               %{"id" => 1234},
               %{"id" => 1235}
             ]
    end
  end

  describe "create" do
    test "incorrect auth" do
      unauthorized = APIReturns.unauthorized()

      expect(
        ChargebeeElixir.HTTPClientMock,
        :post,
        fn _url, _body, _headers ->
          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = ChargebeeElixir.Addon.create(%{})
    end

    test "incorrect data" do
      bad_request = APIReturns.bad_request()

      expect(
        ChargebeeElixir.HTTPClientMock,
        :post,
        fn _url, _body, _headers ->
          {:ok, 400, [], Jason.encode!(bad_request)}
        end
      )

      assert {:error, 400, [], ^bad_request} = ChargebeeElixir.Addon.create(%{id: "addon-a"})
    end

    test "correct data" do
      expect(
        ChargebeeElixir.HTTPClientMock,
        :post,
        fn _url, _body, _headers ->
          {:ok, 200, [], Jason.encode!(%{addon: %{id: "addon-a"}})}
        end
      )

      assert {:ok, %Addon{id: "addon-a"}} = ChargebeeElixir.Addon.create(%{id: "addon-a"})
    end
  end
end
