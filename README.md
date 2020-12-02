# ChargebeeElixir


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
- plan
- portal_session
- subscription

## Installation
The package can be installed by adding `chargebee_elixir` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:chargebee_elixir, "~> 0.1.0"}
  ]
end
```

## Configuration
```elixir
# config/dev.ex
config :chargebee_elixir,
  namespace: "$your_namespace",
  api_key: "$your_api_key"
```

## Usage
```elixir
# e.g.
ChargebeeElixir.Plan.list()
```

## Run tests
```sh
mix test
```
