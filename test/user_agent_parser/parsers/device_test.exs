defmodule UserAgentParser.Parsers.DeviceTest do
  use ExUnit.Case

  alias UserAgentParser.Parsers.Device, as: Parser
  alias UserAgentParser.{Device, Storage}

  @user_string "Mozilla/5.0 (iPod; U; CPU iPhone OS 4_3_2 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8H7 Safari/6533.18.5"

  test "parses device information" do
    {_, _, [pattern|_]} = Storage.list

    result = Parser.parse({pattern, ["iPod;", "iPod"]})
    assert %Device{family: "iPod"} = result
  end
end
