defmodule Chargebeex.Client do
  @callback get(url :: binary(), body :: binary(), headers :: List.t()) ::
              {:ok, integer(), list(), any()} | {:error, integer(), list(), any()}
  @callback post(url :: binary(), body :: binary(), headers :: List.t()) ::
              {:ok, integer(), list(), any()} | {:error, integer(), list(), any()}
end
