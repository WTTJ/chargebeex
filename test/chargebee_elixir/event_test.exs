defmodule ChargebeeElixir.EventTest do
  use ExUnit.Case, async: true

  import Mox

  alias ChargebeeElixir.Fixtures.Common
  alias ChargebeeElixir.Fixtures.Event, as: FixtureEvent

  alias ChargebeeElixir.Event
  alias ChargebeeElixir.Customer

  setup :verify_on_exit!

  describe "retrieve" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        ChargebeeElixir.HTTPClientMock,
        :get,
        fn _url, _body, _headers ->
          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = Event.retrieve(1234)
    end

    test "with resource not found should fail" do
      not_found = Common.not_found()

      expect(
        ChargebeeElixir.HTTPClientMock,
        :get,
        fn _url, _body, _headers ->
          {:ok, 404, [], Jason.encode!(not_found)}
        end
      )

      assert {:error, 404, [], ^not_found} = Event.retrieve(1234)
    end

    test "with resource found should succeed" do
      expect(
        ChargebeeElixir.HTTPClientMock,
        :get,
        fn _url, _body, _headers ->
          {:ok, 200, [], Jason.encode!(FixtureEvent.customer_updated())}
        end
      )

      assert {:ok, %Event{content: %{"customer" => %Customer{}}}} = Event.retrieve(1234)
    end
  end

  describe "list" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        ChargebeeElixir.HTTPClientMock,
        :get,
        fn _url, _body, _headers ->
          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = Event.list()
    end

    test "with no param, no offset should succeed" do
      expect(
        ChargebeeElixir.HTTPClientMock,
        :get,
        fn _url, _body, _headers ->
          {:ok, 200, [],
           Jason.encode!(%{
             list: [FixtureEvent.customer_updated(), FixtureEvent.customer_updated()]
           })}
        end
      )

      assert {:ok, [%Event{}, %Event{}], %{"next_offset" => nil}} = Event.list()
    end

    test "with limit & offset params should succeed" do
      expect(
        ChargebeeElixir.HTTPClientMock,
        :get,
        fn _url, _body, _headers ->
          result = %{
            list: [FixtureEvent.customer_updated()],
            next_offset: "foobar"
          }

          {:ok, 200, [], Jason.encode!(result)}
        end
      )

      assert {:ok, [%Event{}], %{"next_offset" => "foobar"}} = Event.list(%{limit: 1})
    end
  end
end
