defmodule ChargebeeElixir.SubscriptionTest do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  def subject do
    ChargebeeElixir.Subscription.create_for_customer(
      "cus_1",
      %{
        plan_id: "plan-a",
        addons: [
          %{id: "addon-a"},
          %{id: "addon-b"}
        ]
      }
    )
  end

  describe "create_for_customer" do
    test "incorrect auth" do
      expect(
        ChargebeeElixir.HTTPoisonMock,
        :post!,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/customers/cus_1/subscriptions"

          assert data == "addons[id][0]=addon-a&addons[id][1]=addon-b&plan_id=plan-a"

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
        subject()
      end
    end

    test "not found" do
      expect(
        ChargebeeElixir.HTTPoisonMock,
        :post!,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/customers/cus_1/subscriptions"

          assert data == "addons[id][0]=addon-a&addons[id][1]=addon-b&plan_id=plan-a"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          %{
            status_code: 404
          }
        end
      )

      assert_raise ChargebeeElixir.NotFoundError, fn ->
        subject()
      end
    end

    test "incorrect data" do
      expect(
        ChargebeeElixir.HTTPoisonMock,
        :post!,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/customers/cus_1/subscriptions"

          assert data == "addons[id][0]=addon-a&addons[id][1]=addon-b&plan_id=plan-a"

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
        subject()
      end
    end

    test "correct data" do
      expect(
        ChargebeeElixir.HTTPoisonMock,
        :post!,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/customers/cus_1/subscriptions"

          assert data == "addons[id][0]=addon-a&addons[id][1]=addon-b&plan_id=plan-a"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          %{
            status_code: 200,
            body: '{"subscription": {"id": "sub-a"}}'
          }
        end
      )

      assert subject() == %{"id" => "sub-a"}
    end
  end
end
