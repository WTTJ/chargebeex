defmodule Chargebeex.BillingAddress do
  use TypedStruct

  typedstruct do
    field :first_name, String.t()
    field :last_name, String.t()
    field :email, String.t()
    field :company, String.t()
    field :phone, String.t()
    field :line1, String.t()
    field :line2, String.t()
    field :line3, String.t()
    field :city, String.t()
    field :state_code, String.t()
    field :state, String.t()
    field :country, String.t()
    field :zip, String.t()
    field :validation_status, String.t()
  end

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
end
