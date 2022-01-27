defmodule Chargebeex.Customer do
  defstruct [
    :allow_direct_debit,
    :auto_collection,
    :card_status,
    :channel,
    :company,
    :created_at,
    :deleted,
    :email,
    :excess_payments,
    :id,
    :locale,
    :net_term_days,
    :object,
    :pii_cleared,
    :preferred_currency_code,
    :promotional_credits,
    :refundable_credits,
    :resource_version,
    :taxability,
    :unbilled_charges,
    :updated_at,
    :_raw_payload
  ]

  use Chargebeex.Resource, resource: "customer"

  def build(raw_data) do
    attrs = %{
      allow_direct_debit: raw_data["allow_direct_debit"],
      auto_collection: raw_data["auto_collection"],
      card_status: raw_data["card_status"],
      channel: raw_data["channel"],
      company: raw_data["company"],
      created_at: raw_data["created_at"],
      deleted: raw_data["deleted"],
      email: raw_data["email"],
      excess_payments: raw_data["excess_payments"],
      id: raw_data["id"],
      locale: raw_data["locale"],
      net_term_days: raw_data["net_term_days"],
      object: raw_data["object"],
      pii_cleared: raw_data["pii_cleared"],
      preferred_currency_code: raw_data["preferred_currency_code"],
      promotional_credits: raw_data["promotional_credits"],
      refundable_credits: raw_data["refundable_credits"],
      resource_version: raw_data["resource_version"],
      taxability: raw_data["taxability"],
      unbilled_charges: raw_data["unbilled_charges"],
      updated_at: raw_data["updated_at"],
      _raw_payload: raw_data
    }

    struct(__MODULE__, attrs)
  end

  @doc """
  Allows to create a Customer

  ## Examples

      iex> Chargebeex.Customer.create(%{company: "MyCompany"})
      {:ok, %Chargebeex.Customer{
          _raw_payload: [...],
          allow_direct_debit: false,
          auto_collection: "on",
          card_status: "no_card",
          channel: "web",
          company: "MyCompany",
          created_at: 1643297894,
          deleted: false,
          email: nil,
          excess_payments: 0,
          id: "AzyzkCSvjSUpY4xuB",
          locale: nil,
          net_term_days: 0,
          object: "customer",
          pii_cleared: "active",
          preferred_currency_code: "EUR",
          promotional_credits: 0,
          refundable_credits: 0,
          resource_version: 1643297894617,
          taxability: "taxable",
          unbilled_charges: 0,
          updated_at: 1643297894
      }}
  """
  def create(params), do: super(params)

  @doc """
  Allows to list Customers

  Available filters can be found here: https://apidocs.chargebee.com/docs/api/customers#list_customers

  ## Examples

      iex> filters = %{limit: 2}
      iex(2)> Chargebeex.Customer.list(filters)
      {:ok, [%Chargebeex.Customer{...}, %Chargebeex.Customer{...}], %{"next_offset" => nil}}
  """
  def list(params), do: super(params)

  @doc """
  Allows to retrieve a Customer.

  ## Examples

      iex> Chargebeex.Customer.retrieve("AzyzkCSvjSUpY4xuB")
      {:ok, %Chargebeex.Customer{
          _raw_payload: [...],
          allow_direct_debit: false,
          auto_collection: "on",
          card_status: "no_card",
          channel: "web",
          company: "MyCompany",
          created_at: 1643297894,
          deleted: false,
          email: nil,
          excess_payments: 0,
          id: "AzyzkCSvjSUpY4xuB",
          locale: nil,
          net_term_days: 0,
          object: "customer",
          pii_cleared: "active",
          preferred_currency_code: "EUR",
          promotional_credits: 0,
          refundable_credits: 0,
          resource_version: 1643297894617,
          taxability: "taxable",
          unbilled_charges: 0,
          updated_at: 1643297894
      }}
  """
  def retrieve(params), do: super(params)

  @doc """
  Allows to update a Customer

  ## Examples

      iex> Chargebeex.Customer.update("AzyzkCSvjSUpY4xuB", %{company: "MyUpdatedCompany"})
      {:ok, %Chargebeex.Customer{
          _raw_payload: [...],
          allow_direct_debit: false,
          auto_collection: "on",
          card_status: "no_card",
          channel: "web",
          company: "MyUpdatedCompany",
          created_at: 1643297894,
          deleted: false,
          email: nil,
          excess_payments: 0,
          id: "AzyzkCSvjSUpY4xuB",
          locale: nil,
          net_term_days: 0,
          object: "customer",
          pii_cleared: "active",
          preferred_currency_code: "EUR",
          promotional_credits: 0,
          refundable_credits: 0,
          resource_version: 1643297894617,
          taxability: "taxable",
          unbilled_charges: 0,
          updated_at: 1643297894
      }}
  """
  def update(id, params), do: super(id, params)
end
