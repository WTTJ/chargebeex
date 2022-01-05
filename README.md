# Chargebeex

Elixir implementation of [Chargebee API](https://apidocs.chargebee.com/docs/api).

## v0.1.1

This is a work in progress: right now, we only implement those methods:

- list
- retrieve
- create

on those resources:

- addon
- customer
- hosted_page
  - also checkout_new
  - also checkout_existing
- subscription
  - also create_for_customer
- plan
- portal_session
- subscription
- invoice
  - also close

## Installation

The package can be installed by adding `chargebeex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:chargebeex, "~> 0.1.3"}
  ]
end
```

## Configuration

```elixir
# config/dev.ex
config :chargebeex,
  namespace: "$your_namespace",
  api_key: "$your_api_key"
```

## Usage

```elixir
# e.g.
Chargebeex.Plan.list()
```

## Run tests

```sh
mix test
```

## Generate doc tests

```sh
sh generate_doc.sh
```
