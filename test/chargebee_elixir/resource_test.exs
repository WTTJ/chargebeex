defmodule Chargebeex.ResourceTest do
  use ExUnit.Case, async: true

  alias Chargebeex.Resource

  describe "add_custom_fields/1" do
    test "should add custom fields" do
      raw_data = %{
        "whatever" => "whatever",
        "cf_whatever" => "whatever"
      }

      assert %{foo: "bar", custom_fields: %{"cf_whatever" => "whatever"}} =
               %{foo: "bar"}
               |> Resource.add_custom_fields(raw_data)
    end
  end
end
