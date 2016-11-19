defmodule UserAgentParser.Parsers.UserAgent do
  alias UserAgentParser.{UserAgent, Parsers.Base}

  import Base

  replacement_parser struct: UserAgent,
                       keys: [:family_replacement,
                              :os_replacement,
                              :os_replacement,
                              :os_replacement,
                              :os_replacement]
end
