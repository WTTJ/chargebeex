defmodule Chargebeex.ClientBehaviour do
  @moduledoc """
    Define the callbacks for a client to get the data from Chargebee.
  """
  @callback get(url :: binary(), body :: binary(), headers :: list()) ::
              {:ok, integer(), list(), any()} | {:error, integer(), list(), any()}
  @callback post(url :: binary(), body :: binary(), headers :: list()) ::
              {:ok, integer(), list(), any()} | {:error, integer(), list(), any()}
end
