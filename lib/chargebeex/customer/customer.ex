defmodule Chargebeex.Customer do
  @resource "customer"

  defstruct [
    :allow_direct_debit,
    :auto_collection,
    :billing_address,
    :business_customer_without_vat_number,
    :card_status,
    :channel,
    :company,
    :created_at,
    :deleted,
    :email,
    :excess_payments,
    :first_name,
    :last_name,
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
    :vat_number,
    :vat_number_validated_time,
    :vat_number_status,
    :primary_payment_source_id,
    :backup_payment_source_id,
    resources: %{},
    custom_fields: %{}
  ]

  use Chargebeex.Resource, resource: @resource

  def build(raw_data) do
    attrs =
      %{
        allow_direct_debit: raw_data["allow_direct_debit"],
        auto_collection: raw_data["auto_collection"],
        billing_address: raw_data["billing_address"],
        business_customer_without_vat_number: raw_data["business_customer_without_vat_number"],
        card_status: raw_data["card_status"],
        channel: raw_data["channel"],
        company: raw_data["company"],
        created_at: raw_data["created_at"],
        deleted: raw_data["deleted"],
        email: raw_data["email"],
        excess_payments: raw_data["excess_payments"],
        first_name: raw_data["first_name"],
        id: raw_data["id"],
        last_name: raw_data["last_name"],
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
        vat_number: raw_data["vat_number"],
        vat_number_validated_time: raw_data["vat_number_validated_time"],
        vat_number_status: raw_data["vat_number_status"],
        primary_payment_source_id: raw_data["primary_payment_source_id"],
        backup_payment_source_id: raw_data["backup_payment_source_id"]
      }
      |> Chargebeex.Resource.add_custom_fields(raw_data)

    struct(__MODULE__, attrs)
  end

  @type t :: %__MODULE__{
          allow_direct_debit: boolean(),
          auto_collection: String.t(),
          billing_address: map(),
          business_customer_without_vat_number: boolean(),
          card_status: String.t(),
          channel: String.t(),
          company: String.t(),
          created_at: integer(),
          deleted: boolean(),
          email: String.t(),
          excess_payments: integer(),
          first_name: String.t(),
          id: String.t(),
          last_name: String.t(),
          locale: String.t(),
          net_term_days: integer(),
          object: String.t(),
          pii_cleared: String.t(),
          preferred_currency_code: String.t(),
          promotional_credits: integer(),
          refundable_credits: integer(),
          resource_version: integer(),
          taxability: String.t(),
          unbilled_charges: integer(),
          updated_at: integer(),
          primary_payment_source_id: String.t(),
          backup_payment_source_id: String.t()
        }

  @doc """
  Allows to create a Customer

  ## Examples

      iex> Chargebeex.Customer.create(%{company: "MyCompany"})
        {:ok, %Chargebeex.Customer{
          allow_direct_debit: false,
          auto_collection: "on",
          business_customer_without_vat_number: false,
          card_status: "no_card",
          channel: "web",
          company: "MyCompany",
          created_at: 1648489755,
          custom_fields: %{
            "cf_internal_identifier" => "1234",
            "cf_other_custom_field" => "foobar"
          },
          deleted: false,
          email: nil,
          excess_payments: 0,
          id: "169ljDT1Op0yuxET",
          locale: nil,
          net_term_days: 0,
          object: "customer",
          pii_cleared: "active",
          preferred_currency_code: "EUR",
          promotional_credits: 0,
          refundable_credits: 0,
          resource_version: 1648489755361,
          resources: %{},
          taxability: "taxable",
          unbilled_charges: 0,
          updated_at: 1648489755
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
  Allows to retrieve a Customer

  ## Examples

      iex> Chargebeex.Customer.retrieve("AzyzkCSvjSUpY4xuB")
      {:ok, %Chargebeex.Customer{
          allow_direct_debit: false,
          auto_collection: "on",
          business_customer_without_vat_number: false,
          card_status: "no_card",
          channel: "web",
          company: "MyCompany",
          created_at: 1648489755,
          custom_fields: %{
            "cf_internal_identifier" => "1234",
            "cf_other_custom_field" => "foobar"
          },
          deleted: false,
          email: nil,
          excess_payments: 0,
          id: "169ljDT1Op0yuxET",
          locale: nil,
          net_term_days: 0,
          object: "customer",
          pii_cleared: "active",
          preferred_currency_code: "EUR",
          promotional_credits: 0,
          refundable_credits: 0,
          resource_version: 1648489755361,
          resources: %{
            "card" => %Chargebeex.Card{
              billing_addr1: "my_address",
              billing_addr2: nil,
              billing_city: "Paris",
              billing_country: "FR",
              billing_state: nil,
              billing_state_code: nil,
              billing_zip: "12345",
              card_type: "visa",
              created_at: 1648490053,
              customer_id: "169ljDT1Op0yuxET",
              expiry_month: 12,
              expiry_year: 2023,
              first_name: "John",
              funding_type: "credit",
              gateway: "chargebee",
              gateway_account_id: "gw_AzqPCGS1aaz5K3b",
              iin: "411111",
              ip_address: nil,
              issuing_country: nil,
              last4: "1111",
              last_name: "M",
              masked_number: "************1111",
              object: "card",
              payment_source_id: "pm_AzqYbtT1OqGcr5B1",
              powered_by: nil,
              ref_tx_id: nil,
              resource_version: 1648490053804,
              status: "valid",
              updated_at: 1648490053
            }
          },
          taxability: "taxable",
          unbilled_charges: 0,
          updated_at: 1648489755
          }}
  """
  def retrieve(params), do: super(params)

  @doc """
  Allows to update a Customer

  ## Examples

      iex> Chargebeex.Customer.update("169ljDT1Op0yuxET", %{company: "MyUpdatedCompany"})
      {:ok, %Chargebeex.Customer{
          allow_direct_debit: false,
          auto_collection: "on",
          business_customer_without_vat_number: false,
          card_status: "no_card",
          channel: "web",
          company: "MyUpdatedCompany",
          created_at: 1648489755,
          custom_fields: %{
            "cf_internal_identifier" => "1234",
            "cf_other_custom_field" => "foobar"
          },
          deleted: false,
          email: nil,
          excess_payments: 0,
          id: "169ljDT1Op0yuxET",
          locale: nil,
          net_term_days: 0,
          object: "customer",
          pii_cleared: "active",
          preferred_currency_code: "EUR",
          promotional_credits: 0,
          refundable_credits: 0,
          resource_version: 1648489755361,
          resources: %{
            "card" => %Chargebeex.Card{
              billing_addr1: "my_address",
              billing_addr2: nil,
              billing_city: "Paris",
              billing_country: "FR",
              billing_state: nil,
              billing_state_code: nil,
              billing_zip: "12345",
              card_type: "visa",
              created_at: 1648490053,
              customer_id: "169ljDT1Op0yuxET",
              expiry_month: 12,
              expiry_year: 2023,
              first_name: "John",
              funding_type: "credit",
              gateway: "chargebee",
              gateway_account_id: "gw_AzqPCGS1aaz5K3b",
              iin: "411111",
              ip_address: nil,
              issuing_country: nil,
              last4: "1111",
              last_name: "M",
              masked_number: "************1111",
              object: "card",
              payment_source_id: "pm_AzqYbtT1OqGcr5B1",
              powered_by: nil,
              ref_tx_id: nil,
              resource_version: 1648490053804,
              status: "valid",
              updated_at: 1648490053
            }
          },
          taxability: "taxable",
          unbilled_charges: 0,
          updated_at: 1648489755
          }}
  """
  def update(id, params), do: super(id, params)

  @doc """
  Deletes a Customer

  ## Examples

      iex> Chargebeex.Customer.delete("169ljDT1Op0yuxET")
      {:ok, %Chargebeex.Customer{
          allow_direct_debit: false,
          auto_collection: "on",
          business_customer_without_vat_number: false,
          card_status: "no_card",
          channel: "web",
          company: "MyUpdatedCompany",
          created_at: 1648489755,
          custom_fields: %{
            "cf_internal_identifier" => "1234",
            "cf_other_custom_field" => "foobar"
          },
          deleted: false,
          email: nil,
          excess_payments: 0,
          id: "169ljDT1Op0yuxET",
          locale: nil,
          net_term_days: 0,
          object: "customer",
          pii_cleared: "active",
          preferred_currency_code: "EUR",
          promotional_credits: 0,
          refundable_credits: 0,
          resource_version: 1648489755361,
          resources: %{
            "card" => %Chargebeex.Card{
              billing_addr1: "my_address",
              billing_addr2: nil,
              billing_city: "Paris",
              billing_country: "FR",
              billing_state: nil,
              billing_state_code: nil,
              billing_zip: "12345",
              card_type: "visa",
              created_at: 1648490053,
              customer_id: "169ljDT1Op0yuxET",
              expiry_month: 12,
              expiry_year: 2023,
              first_name: "John",
              funding_type: "credit",
              gateway: "chargebee",
              gateway_account_id: "gw_AzqPCGS1aaz5K3b",
              iin: "411111",
              ip_address: nil,
              issuing_country: nil,
              last4: "1111",
              last_name: "M",
              masked_number: "************1111",
              object: "card",
              payment_source_id: "pm_AzqYbtT1OqGcr5B1",
              powered_by: nil,
              ref_tx_id: nil,
              resource_version: 1648490053804,
              status: "valid",
              updated_at: 1648490053
            }
          },
          taxability: "taxable",
          unbilled_charges: 0,
          updated_at: 1648489755
          }}
  """
  def delete(id), do: super(id)

  def update_payment_method(id, params) do
    generic_action(:post, @resource, "update_payment_method", id, params)
  end

  def update_billing_info(id, params) do
    generic_action(:post, @resource, "update_billing_info", id, params)
  end

  def assign_payment_role(id, params) do
    generic_action(:post, @resource, "assign_payment_role", id, params)
  end

  def record_excess_payment(id, params) do
    generic_action(:post, @resource, "record_excess_payment", id, params)
  end

  def collect_payment(id, params) do
    generic_action(:post, @resource, "collect_payment", id, params)
  end

  def move(id, params) do
    generic_action(:post, @resource, "move", id, params)
  end

  def change_billing_date(id, params) do
    generic_action(:post, @resource, "change_billing_date", id, params)
  end

  def merge(id, params) do
    generic_action(:post, @resource, "merge", id, params)
  end

  def clear_personal_data(id) do
    generic_action(:post, @resource, "clear_personal_data", id)
  end

  def relationships(id, params) do
    generic_action(:post, @resource, "relationships", id, params)
  end

  def delete_relationship(id) do
    generic_action(:post, @resource, "delete_relationship", id)
  end

  def hierarchy(id, params) do
    generic_action(:get, @resource, "hierarchy", id, params)
  end

  def update_hierarchy_settings(id, params) do
    generic_action(:post, @resource, "update_hierarchy_settings", id, params)
  end
end
