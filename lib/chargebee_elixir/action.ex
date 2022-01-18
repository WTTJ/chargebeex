defmodule Chargebeex.Action do
  alias Chargebeex.Client

  def retrieve(module, resource, id) do
    with path <- resource_path(resource, id),
         {:ok, _status_code, _headers, %{^resource => content}} <- Client.get(path),
         parsed <- apply(module, :build, [content]) do
      {:ok, parsed}
    end
  end

  def list(module, resource, params \\ %{}) do
    with path <- resource_base_path(resource),
         {:ok, _status_code, _headers, result} <- Client.get(path, params) do
      case result do
        %{"list" => resources, "next_offset" => next_offset} ->
          {:ok, Enum.map(resources, &apply(module, :build, [&1])),
           %{"next_offset" => next_offset}}

        %{"list" => resources} ->
          {:ok, Enum.map(resources, &apply(module, :build, [&1])), %{"next_offset" => nil}}
      end
    end
  end

  def create(module, resource, params) do
    with path <- resource_base_path(resource),
         {:ok, _status_code, _headers, %{^resource => content}} <-
           Client.post(path, params),
         parsed <- apply(module, :build, [content]) do
      {:ok, parsed}
    end
  end

  def update(module, resource, id, params) do
    with path <- resource_path(resource, id),
         {:ok, _status_code, _headers, %{^resource => content}} <-
           Client.post(path, params),
         parsed <- apply(module, :build, [content]) do
      {:ok, parsed}
    end
  end

  defp resource_base_path(resource) do
    "/#{resource}s"
  end

  defp resource_path(resource, id) do
    "#{resource_base_path(resource)}/#{id}"
  end
end
