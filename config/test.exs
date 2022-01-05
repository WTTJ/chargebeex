use Mix.Config

config :chargebeex,
  namespace: "test-namespace",
  api_key: "test_chargeebee_api_key",
  http_client: Chargebeex.HTTPClientMock
