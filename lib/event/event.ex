defmodule ChargebeeElixir.Event do
  defstruct [
    :api_version,
    :content,
    :event_type,
    :id,
    :object,
    :occurred_at,
    :source,
    :webhook_status
  ]

  def build(raw_data) do
    attrs = %{
      api_version: raw_data["api_version"],
      content: raw_data["content"],
      event_type: raw_data["event_type"],
      id: raw_data["id"],
      object: raw_data["object"],
      occurred_at: raw_data["occurred_at"],
      source: raw_data["source"],
      webhook_status: raw_data["webhook_status"],
      _raw: raw_data
    }

    struct(__MODULE__, attrs)
  end
end
