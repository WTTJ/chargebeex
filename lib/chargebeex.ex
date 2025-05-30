defmodule Chargebeex do
  @moduledoc """

  Chargebeex is an Elixir implementation of [Chargebee
  API](https://apidocs.chargebee.com/docs/api).


  ## Installation

  The package can be installed by adding `chargebeex` to your list of
  dependencies in `mix.exs`:

  ```elixir
  # mix.exs
  def deps do
  [
    {:chargebeex, "~> 0.6.0"}
  ]
  end
  ```

  ## Configuration

  Chargebeex can be configured using
  [Config](https://hexdocs.pm/elixir/1.12/Config.html) or environment variables.

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

  ### With Multiple Sites

  To interact with multiple Chargebee sites, scope your Chargebee config to an
  atom or module representing the site. For example, if you have a site called "my_site", you can do the following:

  ```elixir
  config :chargebeex, :my_site,
    namespace: "my-other-namespace",
    api_key: "my-second-api-key"
  ```

  And specify the site when calling the API:
  ```elixir
  {:ok, %Chargebeex.Customer{}} = Chargebeex.Customer.retrieve("foobar", site: :my_site)
  {:ok, [%Chargebeex.Customer{}], [%Chargebeex.Customer{}]} = Chargebeex.Customer.list(site: :my_site)
  {:ok, %Chargebeex.Customer{}} = Chargebeex.Customer.update("foobar", %{name: "updated"}, site: :my_site)
  {:ok, %Chargebeex.Customer{}} = Chargebeex.Customer.delete("foobar", site: :my_site)
  ```

  ### Custom Fields

  Chargebee provides a way to add user-specific fields for resources like
  Customer, Subscriptions, ... called [Custom
  Fields](https://www.chargebee.com/docs/2.0/custom_fields.html).

  These fields are prepended with the `cf_` prefix. These fields can be accessed
  in the special `custom_fields` field of the structure. Please note Custom
  Fields are only available for Customers, Subscriptions, Product Families,
  Plans, Addons and Price Points.

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

  ## Run tests

  ```sh
  mix test
  ```

  ## License
  MIT

  """
end
