# Chargebeex

Elixir implementation of [Chargebee
API](https://apidocs.chargebee.com/docs/api).

This is a heavily inspired fork of the original work by [Nicolas
Marlier](https://github.com/NicolasMarlier/chargebee-elixir)

⚠️ Chargebeex is currently in development and is not suitable for production
use, as the API can break at any time.

## Current status

Some functions are auto-generated and can not work properly. Please open an
issue if this is the case.

## Installation

The package can be installed by adding `chargebeex` to your list of dependencies in `mix.exs`:

```elixir
# mix.exs
def deps do
  [
    {:chargebeex, "~> 0.1.3"}
  ]
end
```

## Configuration

```elixir
# config/dev.exs
config :chargebeex,
  namespace: "my_namespace",
  api_key: "foobar"
```

## Usage

```elixir
# e.g.
Chargebeex.Customer.list()
```

## Run tests

```sh
mix test
```
