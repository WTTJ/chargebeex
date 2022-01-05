defmodule ChargebeeElixir.Resource do
  @callback build(raw_data: Map.t()) :: {:ok, struct()}

  defmacro __using__(resource) do
    quote bind_quoted: [resource: resource] do
      alias ChargebeeElixir.Interface

      @resource resource

      def retrieve(id) do
        with path <- resource_path(id),
             {:ok, status_code, _headers, %{@resource => content}} <- Interface.get(path),
             parsed <- apply(__MODULE__, :build, [content]) do
          {:ok, parsed}
        end
      end

      def list(params \\ %{}) do
        with path <- resource_base_path(),
             {:ok, status_code, _headers, result} <- Interface.get(path, params) do
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
             {:ok, status_code, _headers, %{@resource => content}} <-
               Interface.post(path, params),
             parsed <- apply(__MODULE__, :build, [content]) do
          {:ok, parsed}
        end
      end

      # def update(id, endpoint, params) do
      #   Interface.post("#{resource_path(id)}#{endpoint}", params)[@resource]
      # end

      # def create_for_parent(parent_path, params, path \\ "") do
      #   Interface.post(
      #     "#{parent_path}#{resource_base_path()}#{path}",
      #     params
      #   )[@resource]
      # end

      def build(%{@resource => raw_data}), do: apply(__MODULE__, :build, [raw_data])

      def resource_base_path() do
        "/#{@resource}s"
      end

      def resource_path(id) do
        "#{resource_base_path()}/#{id}"
      end
    end
  end
end
