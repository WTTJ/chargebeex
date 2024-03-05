defmodule Chargebeex.TimeMachine do
  @resource "time_machine"

  use TypedStruct
  use Chargebeex.Resource, resource: @resource, only: [:retrieve]

  typedstruct do
    field :name, String.t()
    field :time_travel_status, String.t()
    field :genesis_time, integer()
    field :destination_time, integer()
    field :failure_code, String.t()
    field :failure_reason, String.t()
    field :error_json, String.t()
    field :object, String.t()
    field :resources, map(), defualt: %{}
  end

  use ExConstructor, :build

  @doc """
    Restart the time machine.
  """
  def start_afresh(id), do: generic_action(:post, @resource, "start_afresh", id)

  @doc """
    Travel forward in time.
  """
  def travel_forward(id, params) do
    generic_action(:post, @resource, "travel_forward", id, params)
  end
end
