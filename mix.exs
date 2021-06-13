defmodule UAParser.Mixfile do
  use Mix.Project

  @source_url "https://github.com/beam-community/ua_parser"
  @version "1.8.0"

  def project do
    [
      app: :ua_parser,
      version: @version,
      elixir: "~> 1.4",
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
      {:yamerl, "~> 0.7"},
      {:credo, "~> 1.0.5", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
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
      source_ref: "v#{@version}",
      formatters: ["html"]
    ]
  end
end
