defmodule Chargebeex.Builder do
  alias Chargebeex.{Card, Customer, Event, PortalSession, Subscription}

  @type opts :: [:with_extra] | []
  @default_opts [with_extra: false]

  @spec build(raw_data :: Map.t(), opts :: opts) :: struct() | Map.t()

  def build(raw_data, resource, opts \\ []) do
    build_(raw_data, resource, Keyword.merge(@default_opts, opts))
  end

  def build_(%{"list" => resources, "next_offset" => next_offset}, resource, opts) do
    {Enum.map(resources, &build_(&1, resource, opts)), %{"next_offset" => next_offset}}
  end

  def build_(%{"list" => resources}, resource, opts) do
    {Enum.map(resources, &build_(&1, resource, opts)), %{"next_offset" => nil}}
  end

  def build_(raw_data, _resource, with_extra: true) when is_map(raw_data) do
    Enum.reduce(raw_data, %{}, fn {k, v}, acc ->
      Map.put(acc, k, build_resource(k, v))
    end)
  end

  def build_(raw_data, resource, _opts) do
    build_resource(resource, Map.get(raw_data, resource))
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
