defmodule ChargebeeElixir.Addon do
  defstruct [
    :charge_type,
    :currency_code,
    :enabled_in_portal,
    :id,
    :invoice_name,
    :is_shippable,
    :name,
    :object,
    :period,
    :period_unit,
    :price,
    :pricing_model,
    :resource_version,
    :show_description_in_invoices,
    :show_description_in_quotes,
    :status,
    :taxable,
    :type,
    :updated_at
  ]

  use ChargebeeElixir.Resource, "addon"

  def build(raw_data) do
    attrs = %{
      charge_type: raw_data["charge_type"],
      currency_code: raw_data["currency_code"],
      enabled_in_portal: raw_data["enabled_in_portal"],
      id: raw_data["id"],
      invoice_name: raw_data["invoice_name"],
      is_shippable: raw_data["is_shippable"],
      name: raw_data["name"],
      object: raw_data["object"],
      period: raw_data["period"],
      period_unit: raw_data["period_unit"],
      price: raw_data["price"],
      pricing_model: raw_data["pricing_model"],
      resource_version: raw_data["resource_version"],
      show_description_in_invoices: raw_data["show_description_in_invoices"],
      show_description_in_quotes: raw_data["show_description_in_quotes"],
      status: raw_data["status"],
      taxable: raw_data["taxable"],
      type: raw_data["type"],
      updated_at: raw_data["updated_at"]
    }

    struct(__MODULE__, attrs)
  end
end
