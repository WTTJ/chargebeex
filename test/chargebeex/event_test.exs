defmodule Chargebeex.EventTest do
  use ExUnit.Case, async: true

  import Hammox

  alias Chargebeex.Fixtures.Common

  alias Chargebeex.Event

  setup :verify_on_exit!

  describe "retrieve" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/events/1234"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = Event.retrieve(1234)
    end

    test "with resource not found should fail" do
      not_found = Common.not_found()

      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/events/1234"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 404, [], Jason.encode!(not_found)}
        end
      )

      assert {:error, 404, [], ^not_found} = Event.retrieve(1234)
    end

    test "with resource found should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/events/1234"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 200, [], Jason.encode!(%{event: %{}})}
        end
      )

      assert {:ok, %Event{}} = Event.retrieve(1234)
    end
  end

  describe "list" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/events"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = Event.list()
    end

    test "with no param, no offset should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/events"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 200, [],
           Jason.encode!(%{
             list: [%{event: %{}}, %{event: %{}}]
           })}
        end
      )

      assert {:ok, [%Event{}, %Event{}], %{"next_offset" => nil}} = Event.list()
    end

    test "with limit & offset params should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/events?limit=1"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          result = %{
            list: [%{event: %{}}],
            next_offset: "foobar"
          }

          {:ok, 200, [], Jason.encode!(result)}
        end
      )

      assert {:ok, [%Event{}], %{"next_offset" => "foobar"}} = Event.list(%{limit: 1})
    end
  end
end
