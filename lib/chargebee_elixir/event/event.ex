defmodule Chargebeex.Event do
  defstruct [
    :api_version,
    :content,
    :event_type,
    :id,
    :object,
    :occurred_at,
    :source,
    :user,
    :webhook_status
  ]

  use Chargebeex.Resource, resource: "event", only: [:retrieve, :list]

  def build(raw_data) do
    attrs = %{
      api_version: raw_data["api_version"],
      event_type: raw_data["event_type"],
      id: raw_data["id"],
      object: raw_data["object"],
      occurred_at: raw_data["occurred_at"],
      source: raw_data["source"],
      user: raw_data["user"],
      webhook_status: raw_data["webhook_status"],
      content: parse_contents(raw_data["content"])
    }

    struct(__MODULE__, attrs)
  end

  defp parse_contents(contents) do
    contents
    |> Enum.map(fn {k, v} ->
      case get_module(k) do
        nil ->
          {k, v}

        module ->
          {k, apply(module, :build, [v])}
      end
    end)
    |> Enum.into(%{})
  end

  defp get_module("customer"), do: Chargebeex.Customer
  defp get_module(_), do: nil
end
