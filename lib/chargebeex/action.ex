defmodule Chargebeex.Action do
  @moduledoc false
  alias Chargebeex.Client
  alias Chargebeex.Builder

  def retrieve(resource, id) do
    with path <- resource_path(resource, id),
         {:ok, _status_code, _headers, content} <- Client.get(path),
         builded <- Builder.build(content) do
      {:ok, put_resources(builded, resource)}
    end
  end

  def list(resource, params \\ %{}) do
    with path <- resource_base_path(resource),
         {:ok, _status_code, _headers, content} <- Client.get(path, params),
         {builded, metadata} <- Builder.build(content) do
      {:ok, Enum.map(builded, &put_resources(&1, resource)), metadata}
    end
  end

  def list_stream(resource, params \\ %{}) do
    path = resource_base_path(resource)
    next_offset = Map.get(params, "next_offset", 0)

    Stream.unfold(next_offset, fn
      nil ->
        nil

      0 ->
        {:ok, _status_code, _headers, response} = Client.get(path, params)

        {Map.get(response, "list"), Map.get(response, "next_offset")}

      offset ->
        params = Map.merge(params, %{"offset" => offset})
        {:ok, _status_code, _headers, response} = Client.get(path, params)

        {Map.get(response, "list"), Map.get(response, "next_offset")}
    end)
    |> Stream.flat_map(& &1)
    |> Stream.map(&Builder.build/1)
    |> Stream.map(&put_resources(&1, resource))
  end

  def create(resource, params) do
    with path <- resource_base_path(resource),
         {:ok, _status_code, _headers, content} <- Client.post(path, params),
         builded <- Builder.build(content) do
      {:ok, put_resources(builded, resource)}
    end
  end

  def update(resource, id, params) do
    with path <- resource_path(resource, id),
         {:ok, _status_code, _headers, content} <- Client.post(path, params),
         builded <- Builder.build(content) do
      {:ok, put_resources(builded, resource)}
    end
  end

  def delete(resource, id) do
    with path <- delete_path(resource, id),
         {:ok, _status_code, _headers, content} <- Client.post(path),
         builded <- Builder.build(content) do
      {:ok, put_resources(builded, resource)}
    end
  end

  def generic_action(verb, resource, action, id, params \\ %{}) do
    with path <- resource_path_generic(resource, id, action),
         {:ok, _status_code, _headers, content} <- apply(Client, verb, [path, params]),
         builded <- Builder.build(content) do
      {:ok, put_resources(builded, resource)}
    end
  end

  defp put_resources(builded, resource) do
    builded
    |> Map.get(resource, %{})
    |> Map.merge(%{resources: Map.drop(builded, [resource])})
  end

  def resource_base_path(resource) do
    "/#{resource}s"
  end

  def resource_path(resource, id) do
    "#{resource_base_path(resource)}/#{id}"
  end

  def resource_path_generic(resource, id, action) do
    Path.join([resource_base_path(resource), id, action])
  end

  def resource_path_generic_without_id(resource, action) do
    Path.join([resource_base_path(resource), action])
  end

  def delete_path(resource, id) do
    Path.join([resource_path(resource, id), "delete"])
  end
end
