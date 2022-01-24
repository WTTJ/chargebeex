defmodule Chargebeex.PortalSessionTest do
  use ExUnit.Case, async: true

  import Mox

  alias Chargebeex.Fixtures.Common
  alias Chargebeex.PortalSession

  setup :verify_on_exit!

  describe "retrieve" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/portal_sessions/1234"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = PortalSession.retrieve(1234)
    end

    test "with resource not found should fail" do
      not_found = Common.not_found()

      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/portal_sessions/1234"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 404, [], Jason.encode!(not_found)}
        end
      )

      assert {:error, 404, [], ^not_found} = PortalSession.retrieve(1234)
    end

    test "with resource found should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :get,
        fn url, body, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/portal_sessions/1234"
          assert headers == [{"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"}]
          assert body == ""

          {:ok, 200, [], Jason.encode!(%{portal_session: %{id: 1234}})}
        end
      )

      assert {:ok, %PortalSession{id: 1234, _raw_payload: %{"id" => 1234}}} ==
               PortalSession.retrieve(1234)
    end
  end

  describe "create" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, data, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/portal_sessions"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert data == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = PortalSession.create(%{})
    end

    test "with invalid data should fail" do
      bad_request = Common.bad_request()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, data, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/portal_sessions"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert data == "foobar=foo"

          {:ok, 400, [], Jason.encode!(bad_request)}
        end
      )

      assert {:error, 400, [], ^bad_request} = PortalSession.create(%{foobar: "foo"})
    end

    test "with valid data should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, data, headers ->
          assert url == "https://test-namespace.chargebee.com/api/v2/portal_sessions"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert data == "customer[id]=foobar"

          {:ok, 200, [], Jason.encode!(%{portal_session: %{id: "foobar", status: "created"}})}
        end
      )

      assert {:ok, %PortalSession{id: "foobar"}} =
               PortalSession.create(%{customer: %{id: "foobar"}})
    end
  end

  describe "logout" do
    test "with bad authentication should fail" do
      unauthorized = Common.unauthorized()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/portal_sessions/foobar/logout"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert data == ""

          {:ok, 401, [], Jason.encode!(unauthorized)}
        end
      )

      assert {:error, 401, [], ^unauthorized} = PortalSession.logout("foobar")
    end

    test "with invalid data should fail" do
      bad_request = Common.bad_request()

      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/portal_sessions/foobar/logout"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert data == ""

          {:ok, 400, [], Jason.encode!(bad_request)}
        end
      )

      assert {:error, 400, [], ^bad_request} = PortalSession.logout("foobar")
    end

    test "with valid data should succeed" do
      expect(
        Chargebeex.HTTPClientMock,
        :post,
        fn url, data, headers ->
          assert url ==
                   "https://test-namespace.chargebee.com/api/v2/portal_sessions/foobar/logout"

          assert headers == [
                   {"Authorization", "Basic dGVzdF9jaGFyZ2VlYmVlX2FwaV9rZXk6"},
                   {"Content-Type", "application/x-www-form-urlencoded"}
                 ]

          assert data == ""

          {:ok, 200, [], Jason.encode!(%{portal_session: %{id: "foobar", status: "logged_out"}})}
        end
      )

      assert {:ok, %PortalSession{id: "foobar"}} = PortalSession.logout("foobar")
    end
  end
end
