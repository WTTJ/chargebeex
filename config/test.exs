use Mix.Config

config :chargebee_elixir,
  namespace: "test-namespace",
  api_key: "test_chargeebee_api_key",
  http_client: ChargebeeElixir.HTTPoisonMock
