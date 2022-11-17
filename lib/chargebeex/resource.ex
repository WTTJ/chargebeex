defmodule Chargebeex.Resource do
  @moduledoc """
    Generic macro implemented by most of the Chargebee resources. Provides
    whenever it is possible retrieve/create/list/update/delete actions for each
    resource.
  """

  @doc """
  Build a raw data map into in an internal structure.
  """
  @callback build(raw_data :: map()) :: struct()

  @doc """
    Retrieve a resource
  """
  @callback retrieve(id :: String.t()) :: {:ok, struct()}
  @doc """
    List a resource
  """
  @callback list(params :: map()) :: {:ok, list(), map()}
  @doc """
    Create a resource
  """
  @callback create(params :: map()) :: {:ok, struct()}
  @doc """
    Update a resource
  """
  @callback update(id :: String.t(), params :: map()) :: {:ok, struct()}
  @doc """
    Delete a resource
  """
  @callback delete(id :: String.t()) :: {:ok, struct()}

  @optional_callbacks retrieve: 1, list: 1, create: 1, update: 2, delete: 1

  defmacro __using__(opts) do
    only = Keyword.get(opts, :only, [:retrieve, :list, :create, :update, :delete])

    quote bind_quoted: [opts: opts, only: only] do
      @behaviour Chargebeex.Resource
      @resource Keyword.fetch!(opts, :resource)
      import Chargebeex.Action,
        only: [
          retrieve: 2,
          list: 2,
          create: 2,
          update: 3,
          delete: 2,
          generic_action: 4,
          generic_action: 5
        ]

      if :retrieve in only do
        def retrieve(id), do: retrieve(@resource, id)
        defoverridable retrieve: 1
      end

      if :list in only do
        def list(params \\ %{}), do: list(@resource, params)
        defoverridable list: 0
        defoverridable list: 1
      end

      if :create in only do
        def create(params), do: create(@resource, params)
        defoverridable create: 1
      end

      if :update in only do
        def update(id, params), do: update(@resource, id, params)
        defoverridable update: 2
      end

      if :delete in only do
        def delete(id), do: delete(@resource, id)
        defoverridable delete: 1
      end
    end
  end

  @doc false
  def add_custom_fields(params, raw_data) do
    custom_fields =
      raw_data
      |> Enum.filter(fn {k, _v} -> String.starts_with?(k, "cf_") end)
      |> Map.new()

    Map.put(params, :custom_fields, custom_fields)
  end
end
