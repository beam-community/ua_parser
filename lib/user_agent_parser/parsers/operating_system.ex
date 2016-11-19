defmodule UserAgentParser.Parsers.OperatingSystem do
  alias UserAgentParser.{OperatingSystem, Parsers.Base}

  import Base

  replacement_parser struct: OperatingSystem,
                       keys: [:os_replacement,
                              :os_v1_replacement,
                              :os_v2_replacement,
                              :os_v3_replacement,
                              :os_v4_replacement]
end
