defmodule UserAgentParser.Parsers.UserAgentTest do
  use ExUnit.Case

  alias UserAgentParser.Parsers.UserAgent, as: Parser
  alias UserAgentParser.{UserAgent, Storage, Version}

  @user_string "Mozilla/5.0 (Windows; U; en-US) AppleWebKit/531.9 (KHTML, like Gecko) AdobeAIR/2.5.1"

  test "parses user agent information" do
    {[pattern|_], _, _} = Storage.list

    result = Parser.parse({pattern, ["AdobeAIR/2.5.1", "AdobeAIR", "2", "5", "1"]})
    version = %Version{major: "2", minor: "5", patch: "1"}
    assert %UserAgent{family: "AdobeAIR", version: ^version} = result
  end
end
