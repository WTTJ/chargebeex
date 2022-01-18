defmodule Chargebeex.MixProject do
  use Mix.Project

  def project do
    [
      app: :chargebeex,
      name: "chargebee-elixir",
      description: "Elixir implementation of Chargebee API (WIP)",
      package: %{
        licenses: ["MIT"],
        links: %{
          github: "https://github.com/NicolasMarlier/chargebee-elixir"
        }
      },
      source_url: "https://github.com/NicolasMarlier/chargebee-elixir",
      homepage_url: "https://github.com/NicolasMarlier/chargebee-elixir",
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
      env: [host: "chargebee.com", path: "/api/v2"]
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
