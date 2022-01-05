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
    :net_term_days,
    :object,
    :pii_cleared,
    :preferred_currency_code,
    :promotional_credits,
    :refundable_credits,
    :resource_version,
    :taxability,
    :unbilled_charges,
    :updated_at
  ]

  @resource "customer"

  use Chargebeex.Resource, @resource

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
      net_term_days: raw_data["net_term_days"],
      object: raw_data["object"],
      pii_cleared: raw_data["pii_cleared"],
      preferred_currency_code: raw_data["preferred_currency_code"],
      promotional_credits: raw_data["promotional_credits"],
      refundable_credits: raw_data["refundable_credits"],
      resource_version: raw_data["resource_version"],
      taxability: raw_data["taxability"],
      unbilled_charges: raw_data["unbilled_charges"],
      updated_at: raw_data["updated_at"]
    }

    struct(__MODULE__, attrs)
  end
end
