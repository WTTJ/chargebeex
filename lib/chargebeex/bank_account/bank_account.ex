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

  def build(raw_data) do
    attrs = %{
      last4: raw_data["last4"],
      name_on_account: raw_data["name_on_account"],
      first_name: raw_data["first_name"],
      last_name: raw_data["last_name"],
      bank_name: raw_data["bank_name"],
      mandate_id: raw_data["mandate_id"],
      account_type: raw_data["account_type"],
      echeck_type: raw_data["echeck_type"],
      account_holder_type: raw_data["account_holder_type"],
      email: raw_data["email"]
    }

    struct(__MODULE__, attrs)
  end
end
