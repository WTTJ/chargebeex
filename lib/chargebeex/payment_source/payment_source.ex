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
    field :card, map()
    field :bank_account, map()
    field :amazon_payment, map()
    field :upi, map()
    field :paypal, map()
    field :mandates, list()
    field :resources, map(), default: %{}
  end

  def build(raw_data) do
    attrs = %{
      id: raw_data["id"],
      resource_version: raw_data["resource_version"],
      updated_at: raw_data["updated_at"],
      created_at: raw_data["created_at"],
      customer_id: raw_data["customer_id"],
      type: raw_data["type"],
      reference_id: raw_data["reference_id"],
      status: raw_data["status"],
      gateway: raw_data["gateway"],
      gateway_account_id: raw_data["gateway_account_id"],
      ip_address: raw_data["ip_address"],
      issuing_country: raw_data["issuing_country"],
      deleted: raw_data["deleted"],
      business_entity_id: raw_data["business_entity_id"],
      card: Card.build(raw_data["card"]),
      bank_account: BankAccount.build(raw_data["bank_account"]),
      amazon_payment: raw_data["amazon_payment"],
      upi: raw_data["upi"],
      paypal: raw_data["paypal"],
      mandates: raw_data["mandates"]
    }

    struct(__MODULE__, attrs)
  end
end
