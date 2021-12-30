defmodule ChargebeeElixir.InterfaceTest do
  use ExUnit.Case

  describe "transform_arrays_for_chargebee" do
    test "simple list" do
      assert ChargebeeElixir.Interface.transform_arrays_for_chargebee([
               %{id: "object-a"},
               %{id: "object-b"}
             ]) == %{
               id: %{
                 0 => "object-a",
                 1 => "object-b"
               }
             }
    end

    test "deep nesting, no lists" do
      assert ChargebeeElixir.Interface.transform_arrays_for_chargebee(%{
               addon: %{
                 id: "addon-a",
                 nested: %{
                   object: %{
                     id: "object-a"
                   }
                 }
               }
             }) == %{
               addon: %{
                 id: "addon-a",
                 nested: %{
                   object: %{
                     id: "object-a"
                   }
                 }
               }
             }
    end

    test "simple nesting" do
      assert ChargebeeElixir.Interface.transform_arrays_for_chargebee(%{
               addons: [
                 %{
                   id: "addon-a",
                   price: 10
                 },
                 %{
                   id: "addon-b",
                   quantity: 2
                 }
               ]
             }) == %{
               addons: %{
                 id: %{
                   0 => "addon-a",
                   1 => "addon-b"
                 },
                 price: %{
                   0 => 10
                 },
                 quantity: %{
                   1 => 2
                 }
               }
             }
    end

    test "incorrect nesting" do
      assert_raise ChargebeeElixir.IncorrectDataFormatError,
                   "Unsupported data: lists should contains objects only",
                   fn ->
                     ChargebeeElixir.Interface.transform_arrays_for_chargebee(%{
                       addons: [
                         %{
                           id: "addon-a",
                           price: 10
                         },
                         %{
                           id: "addon-b",
                           quantity: 2
                         },
                         "a"
                       ]
                     })
                   end
    end

    test "complex nesting" do
      assert ChargebeeElixir.Interface.transform_arrays_for_chargebee(%{
               addons: [
                 %{
                   id: "addon-a",
                   price: 10,
                   nested_objects: [
                     %{
                       id: "object-a"
                     },
                     %{
                       id: "object-b"
                     }
                   ]
                 },
                 %{
                   id: "addon-b",
                   quantity: 2
                 }
               ]
             }) == %{
               addons: %{
                 id: %{
                   0 => "addon-a",
                   1 => "addon-b"
                 },
                 price: %{
                   0 => 10
                 },
                 quantity: %{
                   1 => 2
                 },
                 nested_objects: %{
                   0 => %{
                     id: %{
                       0 => "object-a",
                       1 => "object-b"
                     }
                   }
                 }
               }
             }
    end
  end
end
