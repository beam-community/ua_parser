defmodule UserAgentParser.Parsers.UserAgent do
  alias UserAgentParser.{UserAgent, Parsers.Base}

  import Base
  @behaviour Base

  @replacement_keys [:os_replacement,
                     :os_replacement,
                     :os_replacement,
                     :os_replacement]

  def parse(nil), do: %UserAgent{}
  def parse({group, match}) do
    agent = replace(group[:family_replacement], 1, match)

    match = Enum.slice(match, 1, 4)
    version = parse_version(group, match, @replacement_keys)

    %UserAgent{family: agent, version: version}
  end
end
