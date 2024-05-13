defmodule Chargebeex.AttachedItemTest do
  use ExUnit.Case, async: true

  import Hammox

  alias Chargebeex.Fixtures.Common
  alias Chargebeex.AttachedItem

  setup :verify_on_exit!

  describe "list" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/items/item_id/attached_items"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = AttachedItem.list("item_id")
    end

    test "with no param, no offset should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/items/item_id/attached_items"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 200, [], Jason.encode!(%{list: [%{attached_item: %{}}, %{attached_item: %{}}]})}
        end
      )

      assert {:ok, [%AttachedItem{}, %AttachedItem{}], %{"next_offset" => nil}} =
               AttachedItem.list("item_id")
    end

    test "with limit & offset params should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/items/item_id/attached_items?limit=1&type%5Bis%5D=mandatory"

          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          result = %{
            list: [%{attached_item: %{id: "foo"}}],
            next_offset: "bar"
          }

          {:ok, 200, [], Jason.encode!(result)}
        end
      )

      assert {:ok, [%AttachedItem{}], %{"next_offset" => "bar"}} =
               AttachedItem.list("item_id", %{"type[is]" => "mandatory", limit: 1})
    end
  end
end
