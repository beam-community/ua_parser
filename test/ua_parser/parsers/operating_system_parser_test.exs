defmodule UAParser.Parsers.OperatingSystemTest do
  use ExUnit.Case

  alias UAParser.Parsers.OperatingSystem, as: Parser
  alias UAParser.{OperatingSystem, Version}

  @user_string "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Safari/530.17 Skyfire/2.0"
  @pattern [regex: ~r/((?:Mac ?|; )OS X)[\s\/](?:(\d+)[_.](\d+)(?:[_.](\d+))?|Mach-O)/,
            os_replacement: "Mac OS X"]
  @match ["Mac OS X 10_5_7", "Mac OS X", "10", "5", "7"]

  test "parses operating system information" do
    result  = Parser.parse({@pattern, @match})
    version = %Version{major: "10", minor: "5", patch: "7"}

    assert %OperatingSystem{family: "Mac OS X", version: ^version} = result
  end
end
