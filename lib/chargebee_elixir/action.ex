defmodule Chargebeex.Action do
  alias Chargebeex.Client
  alias Chargebeex.Builder

  def retrieve(resource, id, opts) do
    with path <- resource_path(resource, id),
         {:ok, _status_code, _headers, content} <- Client.get(path) do
      {:ok, Builder.build(content, resource, opts)}
    end
  end

  def list(resource, params \\ %{}, opts) do
    with path <- resource_base_path(resource),
         {:ok, _status_code, _headers, content} <- Client.get(path, params),
         {content, metadata} <- Builder.build(content, resource, opts) do
      {:ok, content, metadata}
    end
  end

  def create(resource, params, opts) do
    with path <- resource_base_path(resource),
         {:ok, _status_code, _headers, content} <- Client.post(path, params) do
      {:ok, Builder.build(content, resource, opts)}
    end
  end

  def update(resource, id, params, opts) do
    with path <- resource_path(resource, id),
         {:ok, _status_code, _headers, content} <- Client.post(path, params) do
      {:ok, Builder.build(content, resource, opts)}
    end
  end

  def delete(resource, id, opts) do
    with path <- delete_path(resource, id),
         {:ok, _status_code, _headers, content} <- Client.post(path) do
      {:ok, Builder.build(content, resource, opts)}
    end
  end

  def generic_action(verb, resource, action, id, params \\ %{}, opts) do
    with path <- resource_path_generic(resource, id, action),
         {:ok, _status_code, _headers, content} <- apply(Client, verb, [path, params]) do
      {:ok, Builder.build(content, resource, opts)}
    end
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

  def delete_path(resource, id) do
    Path.join([resource_path(resource, id), "delete"])
  end
end
