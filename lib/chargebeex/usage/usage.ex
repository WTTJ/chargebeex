defmodule Chargebeex.Usage do
  use TypedStruct

  @resource "usage"
  use Chargebeex.Resource, resource: @resource, only: [:list]

  @moduledoc """
  Struct that represent a Chargebee's API usage resource.
  """

  @typedoc """
  "admin_console" | "api" | "bulk_operation"
  """
  @type source :: String.t()

  typedstruct do
    field :id, String.t()
    field :usage_date, String.t()
    field :subscription_id, String.t()
    field :item_price_id, String.t()
    field :invoice_id, String.t()
    field :line_item_id, String.t()
    field :quantity, String.t()
    field :source, source()
    field :note, String.t()
    field :resource_version, String.t()
    field :updated_at, non_neg_integer()
    field :created_at, non_neg_integer()
  end

  use ExConstructor, :build

  @doc """
  Allows to create a Usage

  ## Examples

      iex> Chargebeex.Usage.create(%{item_price_id: "item_eur_monthly", quantity: 42, usage_date: 1599817250})
        {:ok, %Chargebeex.Usage{}}
  """
  def create(subscription_id, params, opts \\ []) do
    nested_generic_action_without_id(
      :post,
      [subscription: subscription_id],
      @resource,
      "usages",
      params,
      opts
    )
  end

  @doc """
  Allows to retrieve a Usage

  ## Examples

      iex> Chargebeex.Usage.retrieve("e49e39cf-a406-4cc9-b14a-85476b3c3ebf", %{id: "a065d78c-a5a8-458b-85b6-e9295118d3bf"})
        {:ok, %Chargebeex.Usage{}}
  """
  def retrieve(subscription_id, params, opts \\ []) do
    nested_generic_action_without_id(
      :get,
      [subscription: subscription_id],
      @resource,
      "usages",
      params,
      opts
    )
  end

  @doc """
  Allows to delete a Usage

  ## Examples

      iex> Chargebeex.Usage.delete("e49e39cf-a406-4cc9-b14a-85476b3c3ebf", %{id: "a065d78c-a5a8-458b-85b6-e9295118d3bf"})
        {:ok, %Chargebeex.Usage{}}
  """
  def delete(subscription_id, params, opts \\ []) do
    nested_generic_action_without_id(
      :post,
      [subscription: subscription_id],
      @resource,
      "delete_usage",
      params,
      opts
    )
  end
end
