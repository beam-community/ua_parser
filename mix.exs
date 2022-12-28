defmodule UAParser.Mixfile do
  use Mix.Project

  @source_url "https://github.com/beam-community/ua_parser"

  def project do
    [
      app: :ua_parser,
      version: version(),
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
      {:yamerl, "~> 0.8"},
      {:credo, "~> 1.5", only: [:dev, :test]},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      description: "Parse user-agent strings with BrowserScope patterns",
      maintainers: ["Sean Callan", "Nathan Youngman"],
      licenses: ["Apache-2.0"],
      links: %{GitHub: @source_url}
    ]
  end

  defp version do
    "VERSION"
    |> File.read!()
    |> String.trim()
  end
end
