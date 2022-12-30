defmodule Chargebeex.Event do
  use TypedStruct
  use Chargebeex.Resource, resource: "event", only: [:retrieve, :list]

  alias Chargebeex.Builder

  typedstruct do
    field :api_version, String.t()
    field :content, map()
    field :event_type, String.t()
    field :id, String.t()
    field :object, String.t()
    field :occurred_at, integer()
    field :source, String.t()
    field :user, String.t()
    field :webhook_status, String.t()
    field :resources, map(), default: %{}
  end

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
      content: parse_content(raw_data)
    }

    struct(__MODULE__, attrs)
  end

  defp parse_content(raw_data) do
    raw_data
    |> Map.get("content", %{})
    |> Builder.build()
  end
end
