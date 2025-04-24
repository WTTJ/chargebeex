defmodule Chargebeex.OpenTelemetry.Default do
  @moduledoc """
  Default no-op implementation of the OpenTelemetry behaviour.
  """

  @behaviour Chargebeex.OpenTelemetry.OpenTelemetryBehaviour

  @impl true
  def with_span(_name, _attributes, fun), do: fun.()

  @impl true
  def ok(_status_code), do: true

  @impl true
  def error(_status_code, _body), do: true
end
