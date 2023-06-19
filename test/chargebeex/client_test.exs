defmodule Chargebeex.ClientTest do
  use ExUnit.Case, async: true

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
end
