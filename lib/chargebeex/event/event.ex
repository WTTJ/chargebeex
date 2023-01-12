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

  use ExConstructor, :build

  def build(raw_data),
    do:
      raw_data
      |> super()
      |> Map.put(:content, parse_content(raw_data))

  defp parse_content(raw_data) do
    raw_data
    |> Map.get("content", %{})
    |> Builder.build()
  end
end
