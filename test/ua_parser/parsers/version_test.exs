defmodule UAParser.Parsers.VersionTest do
  use ExUnit.Case

  alias UAParser.Parsers.Version, as: Parser
  alias UAParser.Version

  @pattern [regex: ~r/((?:Mac ?|; )OS X)[\s\/](?:(\d+)[_.](\d+)(?:[_.](\d+))?|Mach-O)/,
            os_replacement: "Mac OS X"]
  @match ["Mac OS X", "10", "5", "7"]
  @replacement_keys [:not_used, :not_used, :not_used, :not_used]

  test "parses device information" do
    result = Parser.parse({@pattern, @match}, @replacement_keys)
    assert %Version{major: "10", minor: "5", patch: "7"} = result
  end
end
