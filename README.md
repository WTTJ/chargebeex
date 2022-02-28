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
# e.g.
Chargebeex.Customer.list()
```

### Custom Fields

Chargebee provides a way to add user-specific fields for resources like
Customer, Subscriptions, ... called [Custom
Fields](https://www.chargebee.com/docs/2.0/custom_fields.html).

These fields are prepended with the `cf_` prefix. Unfortunately, it is difficult
to handle these fields in the resource structure, because these are dynamically
provided.

However, a special `_raw_payload` field is present in each structure,
representing the raw result retrieved from the Chargebee API. You can retrieve
you custom fields in this map.

#### Example:

```elixir
 iex> Chargebeex.Customer.retrieve("barbaz")
 {:ok, %Chargebeex.Customer{
     _raw_payload: %{
       "allow_direct_debit" => false,
       "id" => "barbaz",
       "cf_my_custom_field" => "foobar",
       [...]
     },
     allow_direct_debit: false,
     id: "barbaz"
     [...]}
  }
```

## Run tests

```sh
mix test
```
