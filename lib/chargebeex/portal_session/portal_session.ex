defmodule Chargebeex.PortalSession do
  use TypedStruct

  @resource "portal_session"
  use Chargebeex.Resource,
    resource: @resource,
    only: [:create, :retrieve]

  typedstruct do
    field :access_url, String.t()
    field :created_at, non_neg_integer()
    field :customer_id, String.t()
    field :expires_at, non_neg_integer()
    field :id, String.t()
    field :linked_customers, list()
    field :object, String.t()
    field :redirect_url, String.t()
    field :status, String.t()
    field :token, String.t()
    field :resources, map(), default: %{}
  end

  def build(raw_data) do
    attrs = %{
      access_url: raw_data["access_url"],
      created_at: raw_data["created_at"],
      customer_id: raw_data["customer_id"],
      expires_at: raw_data["expires_at"],
      id: raw_data["id"],
      linked_customers: raw_data["linked_customers"],
      object: raw_data["object"],
      redirect_url: raw_data["redirect_url"],
      status: raw_data["status"],
      token: raw_data["token"]
    }

    struct(__MODULE__, attrs)
  end

  @doc """
    Logs out the portal session. This should be called when customers logout of
    your application.
  """
  def logout(id), do: generic_action(:post, @resource, "logout", id)

  @doc """
    When an user is sent back to your return URL with session details, you
    should validate that information by calling this API.
  """
  def activate(id, params), do: generic_action(:post, @resource, "activate", id, params)
end
