defmodule ChargebeeElixir.Fixtures do
  def customer() do
    %{
      "allow_direct_debit" => false,
      "auto_collection" => "on",
      "card_status" => "no_card",
      "cf_welcome_accounts_organization_reference" => "WTTJ",
      "channel" => "web",
      "company" => "WTTJ",
      "created_at" => 1_640_860_244,
      "deleted" => false,
      "email" => "maxime.menager@wttj.co",
      "excess_payments" => 0,
      "id" => "16CIYjSt4UMeF7j0N",
      "net_term_days" => 0,
      "object" => "customer",
      "pii_cleared" => "active",
      "preferred_currency_code" => "EUR",
      "promotional_credits" => 0,
      "refundable_credits" => 0,
      "resource_version" => 1_640_860_244_380,
      "taxability" => "taxable",
      "unbilled_charges" => 0,
      "updated_at" => 1_640_860_244
    }
  end

  def event_customer_updated() do
    %{
      "api_version" => "v2",
      "content" => %{
        "card" => %{
          "card_type" => "jcb",
          "customer_id" => "3Nl7oGgQqGFprj9",
          "expiry_month" => 12,
          "expiry_year" => 2022,
          "funding_type" => "not_known",
          "gateway" => "chargebee",
          "gateway_account_id" => "gw_3Nl7oGgQqGFlba2",
          "iin" => "353011",
          "last4" => "0000",
          "masked_number" => "************0000",
          "object" => "card",
          "payment_source_id" => "pm_3Nl7oGgQqGFwhb1k",
          "status" => "valid"
        },
        "customer" => %{
          "allow_direct_debit" => false,
          "auto_collection" => "on",
          "balances" => [
            %{
              "balance_currency_code" => "USD",
              "currency_code" => "USD",
              "excess_payments" => 0,
              "object" => "customer_balance",
              "promotional_credits" => 0,
              "refundable_credits" => 871,
              "unbilled_charges" => 0
            }
          ],
          "card_status" => "valid",
          "created_at" => 1_341_085_225,
          "deleted" => false,
          "email" => "Benjamin@test.com",
          "excess_payments" => 0,
          "first_name" => "Benjamin",
          "id" => "3Nl7oGgQqGFprj9",
          "last_name" => "Ross",
          "net_term_days" => 0,
          "object" => "customer",
          "payment_method" => %{
            "gateway" => "chargebee",
            "gateway_account_id" => "gw_3Nl7oGgQqGFlba2",
            "object" => "payment_method",
            "reference_id" => "tok_3Nl7oGgQqGFwhM1j",
            "status" => "valid",
            "type" => "card"
          },
          "preferred_currency_code" => "USD",
          "primary_payment_source_id" => "pm_3Nl7oGgQqGFwhb1k",
          "promotional_credits" => 0,
          "refundable_credits" => 871,
          "resource_version" => 1_362_253_266_000,
          "taxability" => "taxable",
          "unbilled_charges" => 0,
          "updated_at" => 1_362_253_266
        }
      },
      "event_type" => "customer_changed",
      "id" => "ev_3Nl7oGgQqGG00y3Q",
      "object" => "event",
      "occurred_at" => 1_362_253_266,
      "source" => "admin_console",
      "webhook_status" => "not_configured"
    }
  end

  def addon() do
    %{
      "charge_type" => "recurring",
      "currency_code" => "USD",
      "enabled_in_portal" => true,
      "id" => "sms_pack",
      "invoice_name" => "sample data pack",
      "is_shippable" => false,
      "name" => "Sms Pack",
      "object" => "addon",
      "period" => 1,
      "period_unit" => "month",
      "price" => 200,
      "pricing_model" => "flat_fee",
      "resource_version" => 1_517_505_775_000,
      "show_description_in_invoices" => false,
      "show_description_in_quotes" => false,
      "status" => "active",
      "taxable" => true,
      "type" => "on_off",
      "updated_at" => 1_517_505_775
    }
  end
end
