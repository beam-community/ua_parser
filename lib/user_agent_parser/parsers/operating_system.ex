defmodule UserAgentParser.Parsers.OperatingSystem do
  alias UserAgentParser.{OperatingSystem, Parsers.Base}

  import Base
  @behaviour Base

  @replacement_keys [:os_v1_replacement,
                     :os_v2_replacement,
                     :os_v3_replacement,
                     :os_v4_replacement]

  def parse(nil), do: %OperatingSystem{}
  def parse({group, match}) do
    os = replace(group[:os_replacement], 1, match)

    match = Enum.slice(match, 1, 4)
    version = parse_version(group, match, @replacement_keys)

    %OperatingSystem{family: os, version: version}
  end
end
