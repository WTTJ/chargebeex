defmodule Chargebeex.PaymentSource do
  defstruct [
    :id,
    :resource_version,
    :updated_at,
    :created_at,
    :customer_id,
    :type,
    :reference_id,
    :status,
    :gateway,
    :gateway_account_id,
    :ip_address,
    :issuing_country,
    :deleted,
    :business_entity_id,
    :card,
    :bank_account,
    :amazon_payment,
    :upi,
    :paypal,
    :mandates,
    resources: %{}
  ]

  alias Chargebeex.Card

  use Chargebeex.Resource, resource: "payment_source", only: [:retrieve, :list, :delete]

  def build(raw_data) do
    attrs = %{
      id: raw_data["id"],
      resource_version: raw_data["resource_version"],
      updated_at: raw_data["updated_at"],
      created_at: raw_data["created_at"],
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
      bank_account: raw_data["bank_account"],
      amazon_payment: raw_data["amazon_payment"],
      upi: raw_data["upi"],
      paypal: raw_data["paypal"],
      mandates: raw_data["mandates"]
    }

    struct(__MODULE__, attrs)
  end
end
