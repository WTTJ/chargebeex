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

  use ExConstructor, :build
end
