defmodule Chargebeex.Builder do
  alias Chargebeex.{Card, Customer, Event, PortalSession, Subscription}

  @spec build(raw_data :: Map.t()) :: struct() | Map.t()

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

  def build_resource("subscription", params), do: Subscription.build(params)
  def build_resource("customer", params), do: Customer.build(params)
  def build_resource("portal_session", params), do: PortalSession.build(params)
  def build_resource("event", params), do: Event.build(params)
  def build_resource("card", params), do: Card.build(params)

  def build_resource(_resource, params), do: params
end
