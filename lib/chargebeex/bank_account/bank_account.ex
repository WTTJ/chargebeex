defmodule Chargebeex.BankAccount do
  defstruct [
    :last4,
    :name_on_account,
    :first_name,
    :last_name,
    :bank_name,
    :mandate_id,
    :account_type,
    :echeck_type,
    :account_holder_type,
    :email
  ]

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

  @type t :: %__MODULE__{
          last4: String.t(),
          name_on_account: String.t(),
          first_name: String.t(),
          last_name: String.t(),
          bank_name: String.t(),
          mandate_id: String.t(),
          account_type: String.t(),
          echeck_type: String.t(),
          account_holder_type: String.t(),
          email: String.t()
        }
end
