defmodule UAParser.Parsers.Base do
  @moduledoc """
  A module representing the base and behaviour for all of our parsers.
  """

  @callback parse(args :: term) :: result :: term | nil

  defmacro replacement_parser(opts) do
    [family_key | replacements] = Keyword.fetch!(opts, :keys)
    mod = opts[:struct]

    quote do
      def parse(nil), do: struct(unquote(mod), %{})

      def parse({group, match}) do
        family =
          group
          |> Keyword.get(unquote(family_key))
          |> UAParser.Parsers.Base.replace(1, match)

        match = Enum.slice(match, 1, 5)
        version = UAParser.Parsers.Version.parse({group, match}, unquote(replacements))

        struct(unquote(mod), %{family: family, version: version})
      end
    end
  end

  def replace(nil, position, match), do: Enum.at(match, position)

  def replace(string, position, match) do
    val = Enum.at(match, position)

    if val do
      String.replace(string, "$#{position}", val)
    else
      string
    end
  end
end
