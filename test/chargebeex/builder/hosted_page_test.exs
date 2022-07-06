defmodule Chargebeex.Builder.HostedPageTest do
  use ExUnit.Case, async: true

  alias Chargebeex.Builder
  alias Chargebeex.Fixtures.HostedPage, as: HostedPageFixture
  alias Chargebeex.HostedPage

  describe "build/1" do
    test "should build a hosted page" do
      builded =
        HostedPageFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()

      assert %{"hosted_page" => %HostedPage{}} = builded
    end

    test "should have hosted page params" do
      hosted_page =
        HostedPageFixture.retrieve()
        |> Jason.decode!()
        |> Builder.build()
        |> Map.get("hosted_page")

      params = HostedPageFixture.hosted_page_params() |> Jason.decode!()

      assert hosted_page.created_at == Map.get(params, "created_at")
      assert hosted_page.embed == Map.get(params, "embed")
      assert hosted_page.expires_at == Map.get(params, "expires_at")
      assert hosted_page.id == Map.get(params, "id")
      assert hosted_page.object == Map.get(params, "object")
      assert hosted_page.resource_version == Map.get(params, "resource_version")
      assert hosted_page.state == Map.get(params, "state")
      assert hosted_page.type == Map.get(params, "type")
      assert hosted_page.updated_at == Map.get(params, "updated_at")
      assert hosted_page.url == Map.get(params, "url")
    end
  end
end
