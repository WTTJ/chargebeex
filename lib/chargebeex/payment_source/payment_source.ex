defmodule Chargebeex.PaymentSource do
  use TypedStruct
  use Chargebeex.Resource, resource: "payment_source", only: [:retrieve, :list, :delete]

  alias Chargebeex.{BankAccount, Card}

  typedstruct do
    field :id, String.t()
    field :resource_version, non_neg_integer()
    field :updated_at, non_neg_integer()
    field :created_at, non_neg_integer()
    field :customer_id, String.t()
    field :type, String.t()
    field :reference_id, String.t()
    field :status, String.t()
    field :gateway, String.t()
    field :gateway_account_id, String.t()
    field :ip_address, String.t()
    field :issuing_country, String.t()
    field :deleted, boolean()
    field :business_entity_id, String.t()
    field :card, Card.t()
    field :bank_account, BankAccount.t()
    field :amazon_payment, map()
    field :upi, map()
    field :paypal, map()
    field :mandates, list()
    field :resources, map(), default: %{}
  end

  use ExConstructor, :build

  def build(raw_data, opts \\ []) do
    card = raw_data |> Map.get("card", %{}) |> Card.build(opts)
    bank_account = raw_data |> Map.get("bank_account", %{}) |> BankAccount.build(opts)

    raw_data
    |> super(opts)
    |> Map.merge(%{
      card: card,
      bank_account: bank_account
    })
  end

  def create_card(params, opts \\ []) do
    generic_action_without_id(:post, @resource, "create_card", params, opts)
  end

  def create_bank_account(params, opts \\ []) do
    generic_action_without_id(:post, @resource, "create_bank_account", params, opts)
  end
end
