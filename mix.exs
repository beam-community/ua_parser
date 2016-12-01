defmodule UAParser.Mixfile do
  use Mix.Project

  @version "1.1.0"

  def project do
    [
      app: :ua_parser,
      description: "Parse user-agent strings with BrowserScope patterns",
      version: @version,
      elixir: "~> 1.3",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [
      applications: [:logger, :yamerl],
      env: UAParser.Mixfile.env(),
      mod: {UAParser, []},
    ]
  end

  defp deps do
    [
      {:yamerl, "~> 0.4.0"},
      {:credo, "~> 0.5", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev},
    ]
  end

  defp package do
    [
      maintainers: ["Sean Callan", "Bobby Grayson"],
      files: ["lib", "mix.exs", "README*", "LICENSE*", "priv"],
      licenses: ["Apache 2.0"],
      links: %{github: "https://github.com/doomspork/ua_parser"}
    ]
  end

  def env do
    [
      patterns: get_patterns_filename,
    ]
  end

  @spec get_patterns_filename() :: String.t
  def get_patterns_filename do
    priv_path =
      :ua_parser
      |> :code.priv_dir()
      |> IO.chardata_to_string()

    default_path = priv_path <> "/patterns.yml"
    Application.get_env(:ua_parser, :patterns, default_path)
  end
end
