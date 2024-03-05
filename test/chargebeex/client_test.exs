defmodule Chargebeex.ClientTest do
  use ExUnit.Case, async: true

  import Hammox

  setup :verify_on_exit!

  alias Chargebeex.Client

  describe "endpoint/1" do
    test "should build simple params" do
      params = %{foo: "bar"}

      assert Client.endpoint(:default, "/", params) ==
               "https://test-namespace.chargebee.com/api/v2/?foo=bar"
    end

    test "should build nested params" do
      params = %{foo: %{bar: "baz"}}

      assert Client.endpoint(:default, "/", params) ==
               "https://test-namespace.chargebee.com/api/v2/?foo[bar]=baz"
    end

    test "when alternative site" do
      params = %{foo: "bar"}

      assert Client.endpoint(:alternative, "/", params) ==
               "https://alternative-namespace.chargebee.com/api/v2/?foo=bar"
    end

    test "when site name collides with application env configuration keys" do
      assert_raise(ArgumentError, fn ->
        Client.endpoint(:host, "/", %{})
      end)
    end

    test "when site name  is not configured" do
      assert_raise(ArgumentError, fn ->
        Client.endpoint(:unkown, "/", %{})
      end)
    end
  end

  describe "get" do
    test "should allow to pass user_details" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/customers"

          assert headers == [
                   {"chargebee-request-origin-ip", "127.0.0.1"},
                   {"chargebee-request-origin-device", "Android"},
                   {"chargebee-request-origin-user-encoded", "dXNlckB0ZXN0LmNvbQ=="},
                   {"chargebee-request-origin-user", "user@test.com"},
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}
                 ]

          assert body == ""

          {:ok, 200, [], Jason.encode!(%{})}
        end
      )

      assert {:ok, 200, [], %{}} =
               Client.get("/customers", %{},
                 user_ip: "127.0.0.1",
                 user_device: "Android",
                 user_email: "user@test.com",
                 user_email_encoded: Base.encode64("user@test.com")
               )
    end

    test "should not add headers that have a value as nil" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/customers"

          assert headers == [
                   {"chargebee-request-origin-ip", "127.0.0.1"},
                   {"chargebee-request-origin-user-encoded", "dXNlckB0ZXN0LmNvbQ=="},
                   {"chargebee-request-origin-user", "user@test.com"},
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}
                 ]

          assert body == ""

          {:ok, 200, [], Jason.encode!(%{})}
        end
      )

      assert {:ok, 200, [], %{}} =
               Client.get("/customers", %{},
                 user_ip: "127.0.0.1",
                 user_device: nil,
                 user_email: "user@test.com",
                 user_email_encoded: Base.encode64("user@test.com")
               )
    end
  end

  describe "post" do
    test "should allow to pass user_details" do
      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/customers"

          assert headers == [
                   {"chargebee-request-origin-ip", "127.0.0.1"},
                   {"chargebee-request-origin-device", "Android"},
                   {"chargebee-request-origin-user-encoded", "dXNlckB0ZXN0LmNvbQ=="},
                   {"chargebee-request-origin-user", "user@test.com"},
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert body == ""

          {:ok, 200, [], Jason.encode!(%{})}
        end
      )

      assert {:ok, 200, [], %{}} =
               Client.post("/customers", %{},
                 user_ip: "127.0.0.1",
                 user_device: "Android",
                 user_email: "user@test.com",
                 user_email_encoded: Base.encode64("user@test.com")
               )
    end

    test "should not add headers that have a value as nil" do
      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/customers"

          assert headers == [
                   {"chargebee-request-origin-ip", "127.0.0.1"},
                   {"chargebee-request-origin-user-encoded", "dXNlckB0ZXN0LmNvbQ=="},
                   {"chargebee-request-origin-user", "user@test.com"},
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert body == ""

          {:ok, 200, [], Jason.encode!(%{})}
        end
      )

      assert {:ok, 200, [], %{}} =
               Client.post("/customers", %{},
                 user_ip: "127.0.0.1",
                 user_device: nil,
                 user_email: "user@test.com",
                 user_email_encoded: Base.encode64("user@test.com")
               )
    end
  end
end
