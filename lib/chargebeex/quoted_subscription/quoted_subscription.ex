defmodule Chargebeex.QuotedSubscription do
  @moduledoc """
  Struct that represent a Chargebee's API quoted subscription.
  """

  defstruct [
    :billing_period,
    :billing_period_unit,
    :remaining_billing_cycles,
    :discounts,
    :coupons,
    :subscription_items
  ]

  @type t :: %__MODULE__{
          billing_period: non_neg_integer(),
          billing_period_unit: String.t(),
          remaining_billing_cycles: non_neg_integer(),
          discounts: [map()],
          coupons: [map()],
          subscription_items: [map()]
        }

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
