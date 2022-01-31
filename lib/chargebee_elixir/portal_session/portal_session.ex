defmodule Chargebeex.PortalSession do
  defstruct [
    :access_url,
    :created_at,
    :customer_id,
    :expires_at,
    :id,
    :linked_customers,
    :object,
    :redirect_url,
    :status,
    :token,
    :_raw_payload
  ]

  use Chargebeex.Resource,
    resource: "portal_session",
    only: [:create, :retrieve],
    extra: [
      {:logout, :post, false},
      {:activate, :post, true}
    ]

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
      token: raw_data["token"],
      _raw_payload: raw_data
    }

    struct(__MODULE__, attrs)
  end
end
