defmodule Chargebeex.OpenTelemetry.OpenTelemetryBehaviour do
  @moduledoc """
  Define the callbacks for an adapter to implement OpenTelemetry.
  """

  @callback with_span(name :: String.t(), attributes :: map(), body :: function()) ::
              {:ok, integer(), list(), any()} | {:error, integer(), list(), any()}

  @callback ok(status_code :: integer()) :: boolean()

  @callback error(status_code :: integer(), body :: map()) :: boolean()
end
