defmodule UserAgentParser.Parsers.OperatingSystemTest do
  use ExUnit.Case

  alias UserAgentParser.Parsers.OperatingSystem, as: Parser
  alias UserAgentParser.{OperatingSystem, Storage, Version}

  @user_string "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Safari/530.17 Skyfire/2.0"

  test "parses operating system information" do
    {_, [pattern|_], _} = Storage.list

    result = Parser.parse({pattern, ["Mac OS X 10_5_7", "Mac OS X", "10", "5", "7"]})
    version = %Version{major: "10", minor: "5", patch: "7"}
    assert %OperatingSystem{family: "Mac OS X", version: ^version} = result
  end
end
