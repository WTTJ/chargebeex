defmodule Chargebeex.MixProject do
  use Mix.Project

  def project do
    [
      app: :chargebeex,
      name: "chargebeex",
      description: "Elixir implementation of Chargebee API v2",
      package: %{
        licenses: ["MIT"],
        links: %{
          github: "https://github.com/WTTJ/chargebeex"
        }
      },
      source_url: "https://github.com/WTTJ/chargebeex",
      homepage_url: "https://github.com/WTTJ/chargebeex",
      version: "0.1.3",
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      env: [
        host: "chargebee.com",
        path: "/api/v2",
        namespace: System.get_env("CHARGEBEEX_NAMESPACE"),
        api_key: System.get_env("CHARGEBEEX_API_KEY")
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.0"},
      {:hackney, "~> 1.18"},
      {:plug, "~>1.11"},
      {:ex_doc, "~> 0.23", only: :dev, runtime: false},
      {:hammox, "~> 0.5", only: :test},
      {:mix_test_watch, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end
end
