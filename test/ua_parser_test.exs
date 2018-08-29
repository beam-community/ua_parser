defmodule UAParserTest do
  use ExUnit.Case
  doctest UAParser

  @user_agent "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Safari/530.17 Skyfire/2.0"

  test "parse user_agent using default patterns" do
    ua = UAParser.parse(@user_agent)
    assert to_string(ua) == "Skyfire 2.0"
    assert to_string(ua.os) == "Mac OS X 10.5.7"
    assert to_string(ua.device) == "Other"
  end

  test "parse user_agent using custom patterns" do
    custom_patterns = {
      [
        [
          regex: ~r/(Skyfire)\/(\d+)\.(\d+)(?:\.(\d+))?/,
          family_replacement: "Testing Pattern $1"
        ]
      ],
      [],
      []
    }

    ua = UAParser.parse(@user_agent, custom_patterns)
    assert ua.family == "Testing Pattern Skyfire"
    assert to_string(ua.version) == "2.0"
  end
end
