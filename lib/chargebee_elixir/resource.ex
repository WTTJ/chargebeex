defmodule Chargebeex.Resource do
  @callback build(raw_data: Map.t()) :: {:ok, struct()}

  defmacro __using__(opts) do
    only = Keyword.get(opts, :only, [:retrieve, :list, :create, :update, :delete])

    quote bind_quoted: [opts: opts, only: only] do
      @resource Keyword.fetch!(opts, :resource)
      import Chargebeex.Action,
        only: [
          retrieve: 3,
          list: 3,
          create: 3,
          update: 4,
          delete: 3,
          generic_action: 5,
          generic_action: 6
        ]

      if :retrieve in only do
        def retrieve(id, opts \\ []), do: retrieve(@resource, id, opts)
        defoverridable retrieve: 1
        defoverridable retrieve: 2
      end

      if :list in only do
        def list(params \\ %{}, opts \\ []), do: list(@resource, params, opts)
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

      opts
      |> Keyword.get(:extra, [])
      |> Enum.each(fn {function_name, verb, accept_params} ->
        if accept_params do
          def unquote(function_name)(id, params, opts \\ []) do
            generic_action(
              unquote(verb),
              @resource,
              unquote(function_name) |> Atom.to_string(),
              id,
              params,
              opts
            )
          end
        else
          def unquote(function_name)(id, opts \\ []) do
            generic_action(
              unquote(verb),
              @resource,
              unquote(function_name) |> Atom.to_string(),
              id,
              opts
            )
          end
        end
      end)
    end
  end
end
