defmodule Chargebeex.BillingAddress do
  defstruct [
    :first_name,
    :last_name,
    :email,
    :company,
    :phone,
    :line1,
    :line2,
    :line3,
    :city,
    :state_code,
    :state,
    :country,
    :zip,
    :validation_status
  ]

  def build(raw_data) do
    attrs = %{
      first_name: raw_data["first_name"],
      last_name: raw_data["last_name"],
      email: raw_data["email"],
      company: raw_data["company"],
      phone: raw_data["phone"],
      line1: raw_data["line1"],
      line2: raw_data["line2"],
      line3: raw_data["line3"],
      city: raw_data["city"],
      state_code: raw_data["state_code"],
      state: raw_data["state"],
      country: raw_data["country"],
      zip: raw_data["zip"],
      validation_status: raw_data["validation_status"]
    }

    struct(__MODULE__, attrs)
  end

  @type t :: %__MODULE__{
          first_name: String.t(),
          last_name: String.t(),
          email: String.t(),
          company: String.t(),
          phone: String.t(),
          line1: String.t(),
          line2: String.t(),
          line3: String.t(),
          city: String.t(),
          state_code: String.t(),
          state: String.t(),
          country: String.t(),
          zip: String.t(),
          validation_status: String.t()
        }
end
