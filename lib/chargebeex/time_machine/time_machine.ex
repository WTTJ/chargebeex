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

  @moduledoc """
  Struct that represent a Chargebee's API TimeMachine.
  """
  def build(raw_data) do
    attrs = %{
      name: raw_data["name"],
      time_travel_status: raw_data["time_travel_status"],
      genesis_time: raw_data["genesis_time"],
      destination_time: raw_data["destination_time"],
      failure_code: raw_data["failure_code"],
      failure_reason: raw_data["failure_reason"],
      error_json: raw_data["error_json"],
      object: raw_data["object"]
    }

    struct(__MODULE__, attrs)
  end

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
