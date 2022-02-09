defmodule Chargebeex.ClientBehaviour do
  @callback get(url :: binary(), body :: binary(), headers :: list()) ::
              {:ok, integer(), list(), any()} | {:error, integer(), list(), any()}
  @callback post(url :: binary(), body :: binary(), headers :: list()) ::
              {:ok, integer(), list(), any()} | {:error, integer(), list(), any()}
end
