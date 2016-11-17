defmodule UserAgentParser.Parsers.VersionTest do
  use ExUnit.Case

  alias UserAgentParser.Parsers.Version, as: Parser
  alias UserAgentParser.{Version, Storage}

  @user_string "Mozilla/5.0 (iPod; U; CPU iPhone OS 4_3_2 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8H7 Safari/6533.18.5"

  @replacement_keys [:not_used, :not_used, :not_used, :not_used]

  test "parses device information" do
    {_, _, [pattern|_]} = Storage.list

    result = Parser.parse({pattern, ["Mac OS X", "10", "5", "7"]}, @replacement_keys)
    assert %Version{major: "10", minor: "5", patch: "7"} = result
  end
end
