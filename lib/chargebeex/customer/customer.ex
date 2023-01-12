defmodule Chargebeex.Customer do
  use TypedStruct

  @resource "customer"
  use Chargebeex.Resource, resource: @resource

  typedstruct do
    field :allow_direct_debit, boolean()
    field :auto_collection, String.t()
    field :billing_address, map()
    field :business_customer_without_vat_number, boolean()
    field :card_status, String.t()
    field :channel, String.t()
    field :company, String.t()
    field :created_at, integer()
    field :deleted, boolean()
    field :email, String.t()
    field :excess_payments, integer()
    field :first_name, String.t()
    field :last_name, String.t()
    field :id, String.t()
    field :locale, String.t()
    field :net_term_days, integer()
    field :object, String.t()
    field :pii_cleared, String.t()
    field :preferred_currency_code, String.t()
    field :promotional_credits, integer()
    field :refundable_credits, integer()
    field :resource_version, integer()
    field :taxability, String.t()
    field :unbilled_charges, integer()
    field :updated_at, integer()
    field :vat_number, String.t()
    field :vat_number_validated_time, integer()
    field :vat_number_status, String.t()
    field :primary_payment_source_id, String.t()
    field :backup_payment_source_id, String.t()
    field :relationship, map()
    field :resources, map(), default: %{}
    field :custom_fields, map(), default: %{}
  end

  use ExConstructor, :build

  def build(raw_data) do
    raw_data
    |> super()
    |> Chargebeex.Resource.add_custom_fields(raw_data)
  end

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
