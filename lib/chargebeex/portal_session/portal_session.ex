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

  use ExConstructor, :build

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
