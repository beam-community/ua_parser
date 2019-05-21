defmodule UAParser.Parsers.UA do
  @moduledoc """
  A parser module representing the user agent from a request.
  """

  alias UAParser.{Parsers.Base, UA}

  import Base

  replacement_parser(
    struct: UA,
    keys: [
      :family_replacement,
      :v1_replacement,
      :v2_replacement,
      :v3_replacement,
      :v4_replacement
    ]
  )
end
