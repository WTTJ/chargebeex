<p align="center">
  <img src="logo.png" />
</p>

# Chargebeex

Chargebeex is an Elixir implementation of [Chargebee
API](https://apidocs.chargebee.com/docs/api).

This is a heavily inspired fork of the original work by [Nicolas
Marlier](https://github.com/NicolasMarlier/chargebee-elixir)

## Project status

Chargebeex is used for several months in production at Welcome to the Jungle.

## Installation

The package can be installed by adding `chargebeex` to your list of dependencies in `mix.exs`:

```elixir
# mix.exs
def deps do
  [
    {:chargebeex, "~> 0.5.0"}
  ]
end
```

## Configuration

Chargebeex can be configured using [Config](https://hexdocs.pm/elixir/1.12/Config.html) or environment variables.

### Config

```elixir
config :chargebeex,
  namespace: "my-namespace",
  api_key: "my-api-key"
```

### Environment variables

```
export CHARGEBEEX_API_KEY=my-api-key
export CHARGEBEEX_NAMESPACE=my-namespace
```

## Usage

```elixir
{:ok, %Chargebeex.Customer{}} = Chargebeex.Customer.retrieve("foobar")
{:ok, [%Chargebeex.Customer{}], [%Chargebeex.Customer{}]} = Chargebeex.Customer.list()
{:ok, %Chargebeex.Customer{}} = Chargebeex.Customer.update("foobar", %{name: "updated"})
{:ok, %Chargebeex.Customer{}} = Chargebeex.Customer.delete("foobar")
```

### Custom Fields

Chargebee provides a way to add user-specific fields for resources like
Customer, Subscriptions, ... called [Custom
Fields](https://www.chargebee.com/docs/2.0/custom_fields.html).

These fields are prepended with the `cf_` prefix. These fields can be accessed
in the special `custom_fields` field of the structure. Please note Custom Fields
are only available for Customers, Subscriptions, Product Families, Plans,
Addons and Price Points.

#### Example:

```elixir
 iex> Chargebeex.Customer.retrieve("barbaz")
 {:ok, %Chargebeex.Customer{
     id: "barbaz",
     allow_direct_debit: false,
     custom_fields: %{
       "cf_my_custom_field" => "foobar"
     },
     [...]}
  }
```

### Extra Resources

Some ressources can have extra infos returned along them. For example, when
querying a Customer, if any card or subscription is linked to this customer,
these resources will also be returned. For internal API simplification, these
fields can be accessed in the `resources` field of the structure.

#### Example:

```elixir
 iex> Chargebeex.Customer.retrieve("barbaz")
 {:ok, %Chargebeex.Customer{
     id: "barbaz",
     allow_direct_debit: false,
      resources: %{
        "card" => %Chargebeex.Card{
          billing_addr1: "my_address",
          billing_addr2: nil,
          billing_city: "Paris",
          ...
          }
      }
     [...]}
  }
```

### OpenTelemetry Integration

Chargebeex now supports OpenTelemetry, allowing users to implement their own span instrumentation for tracing and monitoring. By default, a no-op implementation is provided, but you can define your own adapter by implementing the `Chargebeex.OpenTelemetry.OpenTelemetryBehaviour` module.

#### Default Implementation

The default implementation (`Chargebeex.OpenTelemetry.Default`) does nothing and simply executes the provided function.

#### Custom Implementation Example

To customize OpenTelemetry spans, you can create your own module implementing the `Chargebeex.OpenTelemetry.OpenTelemetryBehaviour`:

```elixir
defmodule MyApp.OpenTelemetryAdapter do
  @behaviour Chargebeex.OpenTelemetry.OpenTelemetryBehaviour

  require OpenTelemetry.Tracer

  @impl true
  def with_span(name, attributes, fun) do
    OpenTelemetry.Tracer.with_span name, %{attributes: attributes} do
      fun.()
    end
  end

  @impl true
  def ok(status_code) do
    OpenTelemetry.Tracer.set_status(OpenTelemetry.status(:ok))

    OpenTelemetry.Tracer.set_attribute(
      OpenTelemetry.SemConv.HTTPAttributes.http_response_status_code(),
      status_code
    )
  end

  @impl true
  def error(status_code, body) do
    OpenTelemetry.Tracer.set_status(OpenTelemetry.status(:error))

    OpenTelemetry.Tracer.set_attributes(%{
      OpenTelemetry.SemConv.HTTPAttributes.http_response_status_code() => status_code,
      OpenTelemetry.SemConv.ErrorAttributes.error_type() => body
    })
  end
end
```

#### Configuration

To use your custom OpenTelemetry adapter, configure it in your application:

```elixir
config :chargebeex, :otel_adapter, MyApp.OpenTelemetryAdapter
```

#### Example Usage

When making API calls, spans will automatically be created using the configured adapter:

```elixir
Chargebeex.Client.get("/customers")
```

This will create a span with attributes such as the HTTP method, URL, and parameters, which can be customized further in your adapter.

For more information on OpenTelemetry, visit the [official documentation](https://opentelemetry.io/).

## Run tests

```sh
mix test
```

## License

MIT
