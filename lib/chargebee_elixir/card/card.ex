defmodule Chargebeex.Card do
  defstruct [
    :payment_source_id,
    :status,
    :gateway,
    :gateway_account_id,
    :ref_tx_id,
    :first_name,
    :last_name,
    :iin,
    :last4,
    :card_type,
    :funding_type,
    :expiry_month,
    :expiry_year,
    :issuing_country,
    :billing_addr1,
    :billing_addr2,
    :billing_city,
    :billing_state_code,
    :billing_state,
    :billing_country,
    :billing_zip,
    :created_at,
    :resource_version,
    :updated_at,
    :ip_address,
    :powered_by,
    :customer_id,
    :masked_number,
    # FIXME: "object" field is present in the returned API fields example, but
    # not as a card attribute definition
    :object,
    _raw_payload: %{}
  ]

  @type t :: %__MODULE__{}

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
      _raw_payload: raw_data
    }

    struct(__MODULE__, attrs)
  end
end
