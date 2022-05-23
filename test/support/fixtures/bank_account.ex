defmodule Chargebeex.Fixtures.BankAccount do
  def bank_account_params() do
    """
    {
      "last4": "1234",
      "name_on_account": "Jacky Jack",
      "first_name": "Jacky",
      "last_name": "Jack",
      "bank_name": "MyBank",
      "mandate_id": "ABCDEF",
      "account_type": "checking",
      "echeck_type": "web",
      "email": "foobar@mycompany.com",
      "object": "bank_account",
      "account_holder_type": "individual"
    }
    """
  end

  def retrieve() do
    """
    {
      "bank_account": #{bank_account_params()}
    }
    """
  end
end
