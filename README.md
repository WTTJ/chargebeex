# Chargebeex

Elixir implementation of [Chargebee
API](https://apidocs.chargebee.com/docs/api).

This is a heavily inspired fork of the original work by [Nicolas
Marlier](https://github.com/NicolasMarlier/chargebee-elixir)

:warning: Chargebeex is currently in development and is not suitable for production
use, as the API can break at any time.

## Current status

Some functions are auto-generated and can not work properly. Please open an
issue if this is the case.

<details>
<summary>Customer</summary>

- [x] Create
- [x] Retrieve
- [x] Update
- [x] Delete
- [x] Update payment method
- [ ] List of contacts
- [ ] Add contacts
- [ ] Update contacts
- [ ] Delete contacts
- [x] Assign payment role
- [x] Record an excess payment
- [x] Collect payment
- [x] Change billing date
- [x] Merge customers
- [x] Clear personal data
- [x] Link a customer
- [x] Delink a customer
- [x] Update hierarchy access settings
</details>
<details>
<summary>Portal Sessions</summary>

- [x] Create
- [x] Retrieve
- [x] Logout
- [x] Activate
</details>

## Installation

The package can be installed by adding `chargebeex` to your list of dependencies in `mix.exs`:

```elixir
# mix.exs
def deps do
  [
    {:chargebeex, "~> 0.1.0"}
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
