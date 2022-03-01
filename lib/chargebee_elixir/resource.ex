defmodule Chargebeex.Resource do
  @callback build(raw_data: Map.t()) :: {:ok, struct()}

  defmacro __using__(opts) do
    only = Keyword.get(opts, :only, [:retrieve, :list, :create, :update, :delete])

    quote bind_quoted: [opts: opts, only: only] do
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

      opts
      |> Keyword.get(:extra, [])
      |> Enum.each(fn {function_name, verb, accept_params} ->
        if accept_params do
          def unquote(function_name)(id, params) do
            generic_action(
              unquote(verb),
              @resource,
              unquote(function_name) |> Atom.to_string(),
              id,
              params
            )
          end
        else
          def unquote(function_name)(id) do
            generic_action(
              unquote(verb),
              @resource,
              unquote(function_name) |> Atom.to_string(),
              id
            )
          end
        end
      end)
    end
  end
end
