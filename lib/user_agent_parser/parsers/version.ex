defmodule UserAgentParser.Parsers.Version do
  alias UserAgentParser.{Version, Parsers.Base}

  import Base
  @behaviour Base

  def parse(nil), do: %Version{}
  def parse({group, match}, keys \\ []) do
    keys
    |> Enum.with_index
    |> Enum.map(fn({key, index}) ->
      group
      |> Keyword.get(key)
      |> replace(index + 1, match)
    end)
    |> version
  end

  defp version([major, minor, patch, patch_minor]),
    do: %Version{major: major, minor: minor, patch: patch, patch_minor: patch_minor}
end
