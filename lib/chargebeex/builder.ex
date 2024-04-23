defmodule Chargebeex.Builder do
  @moduledoc false
  alias Chargebeex.{
    BankAccount,
    BillingAddress,
    Card,
    Customer,
    Event,
    Invoice,
    HostedPage,
    PaymentSource,
    PortalSession,
    Subscription,
    Item,
    ItemPrice,
    Quote,
    QuotedSubscription,
    Usage
  }

  def build(%{"list" => resources, "next_offset" => next_offset}) do
    {Enum.map(resources, &build/1), %{"next_offset" => next_offset}}
  end

  def build(%{"list" => resources}) do
    {Enum.map(resources, &build/1), %{"next_offset" => nil}}
  end

  def build(raw_data) when is_map(raw_data) do
    Enum.reduce(raw_data, %{}, fn {k, v}, acc ->
      Map.put(acc, k, build_resource(k, v))
    end)
  end

  def build_resource(%{"subscription" => params}), do: Subscription.build(params)
  def build_resource(%{"customer" => params}), do: Customer.build(params)
  def build_resource(%{"portal_session" => params}), do: PortalSession.build(params)
  def build_resource(%{"event" => params}), do: Event.build(params)
  def build_resource(%{"card" => params}), do: Card.build(params)
  def build_resource(%{"billing_address" => params}), do: BillingAddress.build(params)
  def build_resource(%{"payment_source" => params}), do: PaymentSource.build(params)
  def build_resource(%{"bank_account" => params}), do: BankAccount.build(params)
  def build_resource(%{"invoice" => params}), do: Invoice.build(params)
  def build_resource(%{"hosted_page" => params}), do: HostedPage.build(params)
  def build_resource(%{"item" => params}), do: Item.build(params)
  def build_resource(%{"item_price" => params}), do: ItemPrice.build(params)
  def build_resource(%{"quote" => params}), do: Quote.build(params)
  def build_resource(%{"quoted_subscription" => params}), do: QuotedSubscription.build(params)
  def build_resource(%{"usage" => params}), do: Usage.build(params)

  def build_resource("subscription", params), do: Subscription.build(params)
  def build_resource("customer", params), do: Customer.build(params)
  def build_resource("portal_session", params), do: PortalSession.build(params)
  def build_resource("event", params), do: Event.build(params)
  def build_resource("card", params), do: Card.build(params)
  def build_resource("billing_address", params), do: BillingAddress.build(params)
  def build_resource("payment_source", params), do: PaymentSource.build(params)
  def build_resource("bank_account", params), do: BankAccount.build(params)
  def build_resource("invoice", params), do: Invoice.build(params)
  def build_resource("hosted_page", params), do: HostedPage.build(params)
  def build_resource("item", params), do: Item.build(params)
  def build_resource("item_price", params), do: ItemPrice.build(params)
  def build_resource("quote", params), do: Quote.build(params)
  def build_resource("quoted_subscription", params), do: QuotedSubscription.build(params)
  def build_resource("usage", params), do: Usage.build(params)

  def build_resource(_resource, params), do: params
end
