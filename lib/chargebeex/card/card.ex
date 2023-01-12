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

  use ExConstructor, :build
end
