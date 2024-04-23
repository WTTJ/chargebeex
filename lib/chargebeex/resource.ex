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
  @callback retrieve(id :: String.t(), opts :: list()) :: {:ok, struct()}
  @doc """
    List a resource
  """
  @callback list(params :: map()) :: {:ok, list(), map()}
  @callback list(params :: map(), opts :: list()) :: {:ok, list(), map()}
  @doc """
    Create a resource
  """
  @callback create(params :: map()) :: {:ok, struct()}
  @callback create(params :: map(), opts :: list()) :: {:ok, struct()}
  @doc """
    Update a resource
  """
  @callback update(id :: String.t(), params :: map()) :: {:ok, struct()}
  @callback update(id :: String.t(), params :: map(), opts :: list()) :: {:ok, struct()}
  @doc """
    Delete a resource
  """
  @callback delete(id :: String.t()) :: {:ok, struct()}
  @callback delete(id :: String.t(), opts :: list()) :: {:ok, struct()}

  @optional_callbacks retrieve: 1,
                      retrieve: 2,
                      list: 1,
                      list: 2,
                      create: 1,
                      create: 2,
                      update: 2,
                      update: 3,
                      delete: 1,
                      delete: 2

  defmacro __using__(opts) do
    only = Keyword.get(opts, :only, [:retrieve, :list, :create, :update, :delete])

    quote bind_quoted: [opts: opts, only: only] do
      @behaviour Chargebeex.Resource
      @resource Keyword.fetch!(opts, :resource)
      import Chargebeex.Action,
        only: [
          retrieve: 3,
          list: 3,
          create: 3,
          update: 4,
          delete: 3,
          generic_action: 4,
          generic_action: 5,
          generic_action: 6,
          generic_action_without_id: 3,
          generic_action_without_id: 4,
          generic_action_without_id: 5,
          nested_generic_action_without_id: 4,
          nested_generic_action_without_id: 5,
          nested_generic_action_without_id: 6
        ]

      if :retrieve in only do
        def retrieve(id, opts \\ []), do: retrieve(@resource, id, opts)
        defoverridable retrieve: 1
        defoverridable retrieve: 2
      end

      if :list in only do
        def list(params \\ %{}, opts \\ []), do: list(@resource, params, opts)
        defoverridable list: 0
        defoverridable list: 1
        defoverridable list: 2
      end

      if :create in only do
        def create(params, opts \\ []), do: create(@resource, params, opts)
        defoverridable create: 1
        defoverridable create: 2
      end

      if :update in only do
        def update(id, params, opts \\ []), do: update(@resource, id, params, opts)
        defoverridable update: 2
        defoverridable update: 3
      end

      if :delete in only do
        def delete(id, opts \\ []), do: delete(@resource, id, opts)
        defoverridable delete: 1
        defoverridable delete: 2
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
