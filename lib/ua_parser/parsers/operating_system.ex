defmodule UAParser.Parsers.OperatingSystem do
  @moduledoc """
  A parser module representing the operating system derived
  from a user agent.
  """

  alias UAParser.{OperatingSystem, Parsers.Base}

  import Base

  replacement_parser struct: OperatingSystem,
                       keys: [:os_replacement,
                              :os_v1_replacement,
                              :os_v2_replacement,
                              :os_v3_replacement,
                              :os_v4_replacement]
end
