defmodule Chargebeex.QuotedSubscription do
  use TypedStruct

  typedstruct do
    field :billing_period, non_neg_integer()
    field :billing_period_unit, String.t()
    field :remaining_billing_cycles, non_neg_integer()
    field :discounts, list()
    field :coupons, list()
    field :subscription_items, list()
  end

  @moduledoc """
  Struct that represent a Chargebee's API quoted subscription.
  """
  def build(raw_data) do
    attrs = %{
      billing_period: raw_data["billing_period"],
      billing_period_unit: raw_data["billing_period_unit"],
      remaining_billing_cycles: raw_data["remaining_billing_cycles"],
      discounts: raw_data["discounts"],
      coupons: raw_data["coupons"],
      subscription_items: raw_data["subscription_items"]
    }

    struct(__MODULE__, attrs)
  end
end
