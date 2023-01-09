defmodule Chargebeex.Card do
  use TypedStruct

  typedstruct do
    field :payment_source_id, String.t()
    field :status, String.t()
    field :gateway, String.t()
    field :gateway_account_id, String.t()
    field :ref_tx_id, String.t()
    field :first_name, String.t()
    field :last_name, String.t()
    field :iin, String.t()
    field :last4, String.t()
    field :card_type, String.t()
    field :funding_type, String.t()
    field :expiry_month, integer()
    field :expiry_year, integer()
    field :issuing_country, String.t()
    field :billing_addr1, String.t()
    field :billing_addr2, String.t()
    field :billing_city, String.t()
    field :billing_state_code, String.t()
    field :billing_state, String.t()
    field :billing_country, String.t()
    field :billing_zip, String.t()
    field :created_at, integer()
    field :resource_version, integer()
    field :updated_at, integer()
    field :ip_address, String.t()
    field :powered_by, String.t()
    field :customer_id, String.t()
    field :masked_number, String.t()
    field :brand, String.t()
    # FIXME: "object" field is present in the returned API fields example, but
    # not as a card attribute definition
    field :object, map()
  end

  def build(raw_data) do
    attrs = %{
      payment_source_id: raw_data["payment_source_id"],
      status: raw_data["status"],
      gateway: raw_data["gateway"],
      gateway_account_id: raw_data["gateway_account_id"],
      ref_tx_id: raw_data["ref_tx_id"],
      first_name: raw_data["first_name"],
      last_name: raw_data["last_name"],
      iin: raw_data["iin"],
      last4: raw_data["last4"],
      card_type: raw_data["card_type"],
      funding_type: raw_data["funding_type"],
      expiry_month: raw_data["expiry_month"],
      expiry_year: raw_data["expiry_year"],
      issuing_country: raw_data["issuing_country"],
      billing_addr1: raw_data["billing_addr1"],
      billing_addr2: raw_data["billing_addr2"],
      billing_city: raw_data["billing_city"],
      billing_state_code: raw_data["billing_state_code"],
      billing_state: raw_data["billing_state"],
      billing_country: raw_data["billing_country"],
      billing_zip: raw_data["billing_zip"],
      created_at: raw_data["created_at"],
      resource_version: raw_data["resource_version"],
      updated_at: raw_data["updated_at"],
      ip_address: raw_data["ip_address"],
      powered_by: raw_data["powered_by"],
      customer_id: raw_data["customer_id"],
      masked_number: raw_data["masked_number"],
      object: raw_data["object"],
      brand: raw_data["brand"]
    }

    struct(__MODULE__, attrs)
  end
end
