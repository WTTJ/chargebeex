defmodule ChargebeeElixirElixir.HostedPageTest do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  describe "checkout_new" do
    test "correct data" do
      expect(
        ChargebeeElixir.HTTPoisonMock,
        :post!,
        fn (url, data, headers) ->
          assert url == "https://test-namespace.chargebee.com/api/v2/hosted_pages/checkout_new"
          assert data == "subscription[addons][][id]=addon-a&subscription[addons][][id]=addon-b&subscription[plan_id]=plan-a"
          assert headers == [
            {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
            {"Content-Type", "application/x-www-form-urlencoded"}
          ]
          %{
            status_code: 200,
            body: '{"hosted_page": {"url": "https://doe.com"}}'
          }
        end
      )

      assert ChargebeeElixir.HostedPage.checkout_new(%{
        subscription: %{
          plan_id: "plan-a",
          addons: [
            %{ id: "addon-a"},
            %{ id: "addon-b"}
          ]
        }
        }) == %{"url" => "https://doe.com"}
    end
  end

  describe "checkout_existing" do
    test "correct data" do
      expect(
        ChargebeeElixir.HTTPoisonMock,
        :post!,
        fn (url, data, headers) ->
          assert url == "https://test-namespace.chargebee.com/api/v2/hosted_pages/checkout_existing"
          assert data == "subscription[addons][][id]=addon-a&subscription[addons][][id]=addon-b&subscription[id]=subscritpion-a&subscription[plan_id]=plan-a"
          assert headers == [
            {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
            {"Content-Type", "application/x-www-form-urlencoded"}
          ]
          %{
            status_code: 200,
            body: '{"hosted_page": {"url": "https://doe.com"}}'
          }
        end
      )

      assert ChargebeeElixir.HostedPage.checkout_existing(%{
        subscription: %{
          id: "subscritpion-a",
          plan_id: "plan-a",
          addons: [
            %{ id: "addon-a"},
            %{ id: "addon-b"}
          ]
        }
        }) == %{"url" => "https://doe.com"}
    end
  end
end
