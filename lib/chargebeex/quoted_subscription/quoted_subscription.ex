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
  use ExConstructor, :build
end
