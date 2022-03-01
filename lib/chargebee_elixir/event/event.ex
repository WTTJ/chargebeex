defmodule Chargebeex.Event do
  alias Chargebeex.Builder

  defstruct [
    :api_version,
    :content,
    :event_type,
    :id,
    :object,
    :occurred_at,
    :source,
    :user,
    :webhook_status,
    resources: %{},
    _raw_payload: %{}
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
      content: parse_content(raw_data),
      _raw_payload: raw_data
    }

    struct(__MODULE__, attrs)
  end

  defp parse_content(raw_data) do
    raw_data
    |> Map.get("content", %{})
    |> Builder.build()
  end
end
