defmodule Chargebeex.HostedPage do
  use TypedStruct

  @resource "hosted_page"
  use Chargebeex.Resource, resource: @resource, only: [:retrieve, :list]

  alias Chargebeex.Client
  alias Chargebeex.Builder

  typedstruct do
    field :id, String.t()
    field :type, String.t()
    field :url, String.t()
    field :state, String.t()
    field :pass_thru_content, String.t()
    field :created_at, integer()
    field :expires_at, integer()
    field :content, map
    field :updated_at, integer()
    field :resource_version, integer()
    field :checkout_info, map()
    field :business_entity_id, String.t()
    # FIXME:"embed" field is present in the returned API fields example, but
    # not as a hosted page attribute definition
    field :embed, String.t()
    field :object, map()
  end

  use ExConstructor, :build

  def collect_now(params, opts \\ []) do
    with path <- Chargebeex.Action.resource_path_generic_without_id("hosted_page", "collect_now"),
         {:ok, _status_code, _headers, content} <- Client.post(path, params, opts),
         builded <- Builder.build(content) do
      {:ok, Map.get(builded, "hosted_page")}
    end
  end

  @doc """
  Creates a Chargebee hosted page to accept payment details from a customer
  and checkout to update the subscription.

  ## Examples

      iex> Chargebeex.HostedPage.checkout_existing_for_items(%{
        subscription: %{id: "subscription_id"},
        layout: "in_app",
        subscription_items: [
          %{item_price_id: "item_price_id", quantity: 1}
        ]
      })
      {:ok, %Chargebeex.HostedPage{}}
  """
  def checkout_existing_for_items(params, opts \\ []) do
    generic_action_without_id(:post, @resource, "checkout_existing_for_items", params, opts)
  end
end
