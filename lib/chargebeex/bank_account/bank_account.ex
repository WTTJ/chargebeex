defmodule Chargebeex.BankAccount do
  use TypedStruct

  typedstruct do
    field :last4, String.t()
    field :name_on_account, String.t()
    field :first_name, String.t()
    field :last_name, String.t()
    field :bank_name, String.t()
    field :mandate_id, String.t()
    field :account_type, String.t()
    field :echeck_type, String.t()
    field :account_holder_type, String.t()
    field :email, String.t()
  end

  use ExConstructor, :build
end
