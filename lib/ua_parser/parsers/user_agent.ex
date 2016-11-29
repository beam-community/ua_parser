defmodule UAParser.Parsers.UA do
  @moduledoc false

  alias UAParser.{UA, Parsers.Base}

  import Base

  replacement_parser struct: UA,
                       keys: [:family_replacement,
                              :os_replacement,
                              :os_replacement,
                              :os_replacement,
                              :os_replacement]
end
