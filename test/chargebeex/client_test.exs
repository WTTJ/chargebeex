defmodule Chargebeex.ClientTest do
  use ExUnit.Case, async: true

  alias Chargebeex.Client

  describe "endpoint/1" do
    test "should build simple params" do
      params = %{foo: "bar"}

      assert Client.endpoint("/", params) ==
               "https://test-namespace.chargebee.com/api/v2/?foo=bar"
    end

    test "should build nested params" do
      params = %{foo: %{bar: "baz"}}

      assert Client.endpoint("/", params) ==
               "https://test-namespace.chargebee.com/api/v2/?foo[bar]=baz"
    end
  end
end
