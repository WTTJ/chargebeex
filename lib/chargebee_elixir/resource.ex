defmodule Chargebeex.Resource do
  @callback build(raw_data: Map.t()) :: {:ok, struct()}

  defmacro __using__(opts) do
    only = Keyword.get(opts, :only, [:retrieve, :list, :create, :update, :delete])

    quote bind_quoted: [opts: opts, only: only] do
      @resource Keyword.fetch!(opts, :resource)
      import Chargebeex.Action, only: [retrieve: 3, list: 3, create: 3, update: 4, delete: 3]

      if :retrieve in only do
        def retrieve(id), do: retrieve(__MODULE__, @resource, id)
        defoverridable retrieve: 1
      end

      if :list in only do
        def list(params \\ %{}), do: list(__MODULE__, @resource, params)
        defoverridable list: 0
        defoverridable list: 1
      end

      if :create in only do
        def create(params), do: create(__MODULE__, @resource, params)
        defoverridable create: 1
      end

      if :update in only do
        def update(id, params), do: update(__MODULE__, @resource, id, params)
        defoverridable update: 2
      end

      if :delete in only do
        def delete(id), do: delete(__MODULE__, @resource, id)
        defoverridable delete: 1
      end

      def build(%{@resource => raw_data}), do: apply(__MODULE__, :build, [raw_data])
    end
  end
end
