defmodule ChargebeeElixir.Resource do
  defmacro __using__(resource) do
    quote do
      alias ChargebeeElixir.Interface

      @resource unquote(resource)

      def retrieve(id) do
        Interface.get("#{resource_base_path()}/#{id}")[@resource]
      rescue
        e in ChargebeeElixir.NotFoundError -> nil
      end

      def list do
        __MODULE__.list(%{})
      end

      def list(params) do
        case Interface.get(resource_base_path(), params) do
          %{"list" => current_list, "next_offset" => next_offset} ->
            Enum.map(current_list, fn(hash) -> hash[@resource] end) ++ __MODULE__.list(Map.merge(params, %{"offset" => next_offset}))
          %{"list" => current_list} ->
            Enum.map(current_list, fn(hash) -> hash[@resource] end)
        end
      end

      def create(params, path \\ "") do
        Interface.post("#{resource_base_path()}#{path}", params)[@resource]
      end

      def resource_base_path() do
        "/#{@resource}s"
      end
    end
  end
end
