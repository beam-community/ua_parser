defmodule UserAgentParser.Mixfile do
  use Mix.Project

  def project do
    [app: :user_agent_parser,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :yamerl],
     mod: {UserAgentParser, []}]
  end

  defp deps do
    [{:yamerl, "~> 0.4.0"}]
  end
end
