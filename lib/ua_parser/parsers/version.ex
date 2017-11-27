defmodule UAParser.Parsers.Version do
  @moduledoc """
  A parser module representing the full version of a given
  browser derived from the user agent.
  """

  @behaviour UAParser.Parsers.Base

  import UAParser.Parsers.Base

  alias UAParser.Version

  def parse(nil), do: %Version{}

  def parse(grouping, keys \\ []) do
    keys
    |> Enum.with_index()
    |> Enum.map(&parse_version(grouping, &1))
    |> version
  end

  defp parse_version({group, match}, {key, index}) do
    group
    |> Keyword.get(key)
    |> replace(index + 1, match)
  end

  defp version([major]), do: %Version{major: major}

  defp version([major, minor, patch, patch_minor]),
    do: %Version{major: major, minor: minor, patch: patch, patch_minor: patch_minor}
end
