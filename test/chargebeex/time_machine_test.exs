defmodule Chargebeex.TimeMachineTest do
  use ExUnit.Case, async: true

  import Hammox

  alias Chargebeex.Fixtures.{Common, TimeMachine}
  alias Chargebeex.TimeMachine

  setup :verify_on_exit!

  describe "retrieve" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/time_machines/delorean"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = TimeMachine.retrieve("delorean")
    end

    test "with resource not found should fail" do
      not_found = Common.not_found()

      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/time_machines/delorean"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 404, [], Jason.encode!(not_found)}
        end
      )

      assert {:error, 404, [], ^not_found} = TimeMachine.retrieve("delorean")
    end

    test "with resource found should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/time_machines/delorean"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 200, [], Jason.encode!(%{time_machine: %{}})}
        end
      )

      assert {:ok, %TimeMachine{}} = TimeMachine.retrieve("delorean")
    end
  end

  describe "start_afresh" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/time_machines/delorean/start_afresh"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert body == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = TimeMachine.start_afresh("delorean")
    end

    test "with resource not found should fail" do
      not_found = Common.not_found()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/time_machines/delorean/start_afresh"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert body == ""

          {:ok, 404, [], Jason.encode!(not_found)}
        end
      )

      assert {:error, 404, [], ^not_found} = TimeMachine.start_afresh("delorean")
    end

    test "with resource found should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/time_machines/delorean/start_afresh"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert body == ""

          {:ok, 200, [], Jason.encode!(%{time_machine: %{}})}
        end
      )

      assert {:ok, %TimeMachine{}} = TimeMachine.start_afresh("delorean")
    end
  end

  describe "travel_forward" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/time_machines/delorean/travel_forward"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert body == "destination_time=1586274640"

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} =
               TimeMachine.travel_forward("delorean", %{destination_time: 1_586_274_640})
    end

    test "with resource not found should fail" do
      not_found = Common.not_found()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/time_machines/delorean/travel_forward"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert body == "destination_time=1586274640"

          {:ok, 404, [], Jason.encode!(not_found)}
        end
      )

      assert {:error, 404, [], ^not_found} =
               TimeMachine.travel_forward("delorean", %{destination_time: 1_586_274_640})
    end

    test "with resource found should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, body, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/time_machines/delorean/travel_forward"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert body == "destination_time=1586274640"

          {:ok, 200, [], Jason.encode!(%{time_machine: %{}})}
        end
      )

      assert {:ok, %TimeMachine{}} =
               TimeMachine.travel_forward("delorean", %{destination_time: 1_586_274_640})
    end
  end
end
