defmodule UAParser.Mixfile do
  use Mix.Project

  @source_url "https://github.com/beam-community/ua_parser"

  def project do
    [
      app: :ua_parser,
      version: "1.9.3",
      elixir: "~> 1.13",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [extra_aplications: [:logger, :yamerl]]
  end

  defp deps do
    [
      {:yamerl, "~> 0.10"},
      # Dev & Test dependencies
      {:dialyxir, "~> 1.1", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      description: "Parse user-agent strings with BrowserScope patterns",
      maintainers: ["Sean Callan", "Nathan Youngman"],
      files: ["lib", "mix.exs", "README*", "LICENSE*", "priv"],
      licenses: ["Apache-2.0"],
      links: %{GitHub: @source_url}
    ]
  end

  defp docs do
    [
      extras: [
        LICENSE: [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      formatters: ["html"]
    ]
  end
end
