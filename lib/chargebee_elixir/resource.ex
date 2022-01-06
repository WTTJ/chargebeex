defmodule ChargebeeElixir.Resource do
  @callback build(raw_data: Map.t()) :: {:ok, struct()}

  defmacro __using__(resource) do
    quote bind_quoted: [resource: resource] do
      alias ChargebeeElixir.Interface

      @resource resource

      def retrieve(id) do
        with path <- resource_path(id),
             {:ok, _status_code, _headers, %{@resource => content}} <- Interface.get(path),
             parsed <- apply(__MODULE__, :build, [content]) do
          {:ok, parsed}
        end
      end

      def list(params \\ %{}) do
        with path <- resource_base_path(),
             {:ok, _status_code, _headers, result} <- Interface.get(path, params) do
          case result do
            %{"list" => resources, "next_offset" => next_offset} ->
              {:ok, Enum.map(resources, &apply(__MODULE__, :build, [&1])),
               %{"next_offset" => next_offset}}

            %{"list" => resources} ->
              {:ok, Enum.map(resources, &apply(__MODULE__, :build, [&1])),
               %{"next_offset" => nil}}
          end
        end
      end

      def create(params) do
        with path <- resource_base_path(),
             {:ok, _status_code, _headers, %{@resource => content}} <-
               Interface.post(path, params),
             parsed <- apply(__MODULE__, :build, [content]) do
          {:ok, parsed}
        end
      end

      def update(id, params) do
        with path <- resource_path(id),
             {:ok, _status_code, _headers, %{@resource => content}} <-
               Interface.post(path, params),
             parsed <- apply(__MODULE__, :build, [content]) do
          {:ok, parsed}
        end
      end

      def build(%{@resource => raw_data}), do: apply(__MODULE__, :build, [raw_data])

      def resource_base_path() do
        "/#{@resource}s"
      end

      def resource_path(id) do
        "#{resource_base_path()}/#{id}"
      end

      defoverridable retrieve: 1
      defoverridable list: 1
      defoverridable create: 1
      defoverridable update: 2
    end
  end
end
