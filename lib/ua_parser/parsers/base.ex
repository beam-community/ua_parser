defmodule UAParser.Parsers.Base do
  @moduledoc """
  A module repsenting the base and behaviour for all of our parsers.
  """

  @callback parse(args :: term) :: result :: term | nil

  defmacro replacement_parser(opts) do
    [family_key|replacements] = Keyword.fetch!(opts, :keys)
    mod = opts[:struct]

    quote do
      def parse(nil), do: struct(unquote(mod), %{})
      def parse({group, match}) do
        family =
          group
          |> Map.get(unquote(family_key))
          |> UAParser.Parsers.Base.replace(1, match)

        match   = Enum.slice(match, 1, 4)
        version = UAParser.Parsers.Version.parse({group, match}, unquote(replacements))

        struct(unquote(mod), %{family: family, version: version})
      end
    end
  end

  def replace(nil, position, match), do: Enum.at(match, position)
  def replace(string, position, match) do
    val = Enum.at(match, position)
    String.replace(string, "$#{position}", val)
  end
end
