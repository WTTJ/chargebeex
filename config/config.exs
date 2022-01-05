# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :chargebeex,
  host: "chargebee.com",
  path: "/api/v2",
  namespace: System.get_env("CHARGEBEEX_NAMESPACE"),
  api_key: System.get_env("CHARGEBEEX_API_KEY")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
