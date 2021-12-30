defmodule ChargebeeElixir.PortalSessionTest do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  describe "create" do
    test "incorrect auth" do
      expect(
        ChargebeeElixir.HTTPoisonMock,
        :post!,
        fn url, data, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/portal_sessions"
          assert data == ""

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
        ChargebeeElixir.PortalSession.create(%{})
      end
    end

    test "incorrect data" do
      expect(
        ChargebeeElixir.HTTPoisonMock,
        :post!,
        fn url, data, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/portal_sessions"
          assert data == ""

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
        ChargebeeElixir.PortalSession.create(%{})
      end
    end

    test "correct data" do
      expect(
        ChargebeeElixir.HTTPoisonMock,
        :post!,
        fn url, data, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/portal_sessions"
          assert data == "customer[id]=cus_1234&redirect_url=https%3A%2F%2Fredirect.com"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          %{
            status_code: 200,
            body: '{"portal_session": {"url": "https://doe.com"}}'
          }
        end
      )

      assert ChargebeeElixir.PortalSession.create(%{
               redirect_url: "https://redirect.com",
               customer: %{
                 id: "cus_1234"
               }
             }) == %{"url" => "https://doe.com"}
    end
  end
end
