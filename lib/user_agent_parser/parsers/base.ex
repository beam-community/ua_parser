defmodule UserAgentParser.Parsers.Base do
  @moduledoc """
  Base and behaviour for all of our parsers
  """

  alias UserAgentParser.Parsers.Version, as: VersionParser

  @callback parse(args :: term) :: result :: term | nil

  def replace(nil, position, match), do: Enum.at(match, position)
  def replace(string, position, match) do
    val = Enum.at(match, position)
    String.replace(string, "$#{position}", val)
  end

  def parse_version(group, match, keys),
    do: VersionParser.parse({group, match}, keys)
end
