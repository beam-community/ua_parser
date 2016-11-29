defmodule UAParser.ParserTest do
  use ExUnit.Case

  alias UAParser.{Parser, Storage}

  @user_agent "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Safari/530.17 Skyfire/2.0"

  test "parse a user agent given patterns and a string" do
    %{family: family, os: os, version: version} = Parser.parse(Storage.list, @user_agent)

    assert family == "Skyfire"
    assert to_string(version) == "2.0"
    assert os.family == "Mac OS X"
    assert to_string(os.version) == "10.5.7"
  end
end
