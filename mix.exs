defmodule Chargebeex.MixProject do
  use Mix.Project

  @source_url "https://github.com/WTTJ/chargebeex"

  def project do
    [
      app: :chargebeex,
      name: "chargebeex",
      description: "Elixir implementation of Chargebee API v2",
      package: %{
        licenses: ["MIT"],
        links: %{
          github: @source_url
        }
      },
      source_url: @source_url,
      homepage_url: @source_url,
      version: "0.3.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs()
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
      {:mix_test_watch, "~> 1.0", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:typed_struct, "~> 0.3.0"},
      {:dialyxir, ">= 0.0.0", only: [:dev], runtime: false},
      {:exconstructor, "~> 1.2.7"}
    ]
  end

  def docs do
    [
      extras: extras(),
      main: "readme",
      source_url: @source_url,
      homepage_url: @source_url,
      formatters: ["html"],
      groups_for_modules: [
        Client: [
          Chargebeex.ClientBehaviour,
          Chargebeex.Client.Hackney
        ],
        Resources: [
          Chargebeex.Card,
          Chargebeex.Customer,
          Chargebeex.Event,
          Chargebeex.Invoice,
          Chargebeex.PortalSession,
          Chargebeex.Subscription,
          Chargebeex.Quote,
          Chargebeex.HostedPage,
          Chargebeex.ItemPrice,
          Chargebeex.PaymentSource,
          Chargebeex.Item,
          Chargebeex.Usage
        ]
      ]
    ]
  end

  defp extras() do
    ["README.md": [title: "Overview"]]
  end
end
