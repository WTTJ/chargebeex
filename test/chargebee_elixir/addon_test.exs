defmodule ChargebeeElixir.AddonTest do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  describe "retrieve" do
    test "incorrect auth" do
      expect(
        ChargebeeElixir.HTTPoisonMock,
        :get!,
        fn url, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/addons/1234"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]

          %{
            status_code: 401
          }
        end
      )

      assert_raise ChargebeeElixir.UnauthorizedError, fn ->
        ChargebeeElixir.Addon.retrieve(1234)
      end
    end

    test "not found" do
      expect(
        ChargebeeElixir.HTTPoisonMock,
        :get!,
        fn url, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/addons/1234"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]

          %{
            status_code: 404
          }
        end
      )

      assert ChargebeeElixir.Addon.retrieve(1234) == nil
    end

    test "found" do
      expect(
        ChargebeeElixir.HTTPoisonMock,
        :get!,
        fn url, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/addons/1234"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]

          %{
            status_code: 200,
            body: '{"addon": {"id": 1234}}'
          }
        end
      )

      assert ChargebeeElixir.Addon.retrieve(1234) == %{"id" => 1234}
    end
  end

  describe "list" do
    test "incorrect auth" do
      expect(
        ChargebeeElixir.HTTPoisonMock,
        :get!,
        fn url, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/addons"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]

          %{
            status_code: 401
          }
        end
      )

      assert_raise ChargebeeElixir.UnauthorizedError, fn ->
        ChargebeeElixir.Addon.list()
      end
    end

    test "no param, no offset" do
      expect(
        ChargebeeElixir.HTTPoisonMock,
        :get!,
        fn url, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/addons"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]

          %{
            status_code: 200,
            body: '{"list": [{"addon": {"id": 1234}}]}'
          }
        end
      )

      assert ChargebeeElixir.Addon.list() == [%{"id" => 1234}]
    end

    test "headers, offset" do
      expect(
        ChargebeeElixir.HTTPoisonMock,
        :get!,
        fn url, headers ->
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
        ChargebeeElixir.HTTPoisonMock,
        :get!,
        fn url, headers ->
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
      expect(
        ChargebeeElixir.HTTPoisonMock,
        :post!,
        fn url, data, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/addons"
          assert data == "id=addon-a"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          %{
            status_code: 401
          }
        end
      )

      assert_raise ChargebeeElixir.UnauthorizedError, fn ->
        ChargebeeElixir.Addon.create(%{id: "addon-a"})
      end
    end

    test "incorrect data" do
      expect(
        ChargebeeElixir.HTTPoisonMock,
        :post!,
        fn url, data, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/addons"
          assert data == "id=addon-a"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          %{
            status_code: 400,
            body: '{"message": "Unknown"}'
          }
        end
      )

      assert_raise ChargebeeElixir.InvalidRequestError, fn ->
        ChargebeeElixir.Addon.create(%{id: "addon-a"})
      end
    end

    test "correct data" do
      expect(
        ChargebeeElixir.HTTPoisonMock,
        :post!,
        fn url, data, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/addons"
          assert data == "id=addon-a"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          %{
            status_code: 200,
            body: '{"addon": {"id": "addon-a"}}'
          }
        end
      )

      assert ChargebeeElixir.Addon.create(%{id: "addon-a"}) == %{"id" => "addon-a"}
    end
  end
end
