defmodule UAParser.Mixfile do
  use Mix.Project

  @version "1.0.0"

  def project do
    [app: :ua_parser,
     description: "Parse user-agent strings with BrowserScope patterns",
     version: @version,
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     deps: deps()]
  end

  def application do
    [applications: [:logger, :yamerl],
     mod: {UAParser, []}]
  end

  defp deps do
    [
      {:yamerl, "~> 0.4.0"},
      {:credo, "~> 0.5", only: [:dev, :test]},
    ]
  end

  defp package do
    [maintainers: ["Sean Callan"],
     files: ["lib", "mix.exs", "README*", "LICENSE*", "patterns.yml"],
     licenses: ["Apache 2.0"],
     links: %{github: "https://github.com/doomspork/uap-parser"}]
  end
end
