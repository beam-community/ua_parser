defmodule UserAgentParser.ProcessorTest do
  use ExUnit.Case

  alias UserAgentParser.Processor

  test "converts yaml document into data structure" do
    result = Processor.process(test_data)

    assert is_tuple(result)
    assert tuple_size(result) == 3
    assert [[{:regex, pattern}]] = elem(result, 0)
    assert Regex.regex?(pattern)
  end

  def test_data do
    File.cwd!
    |> Path.join("test/fixtures/patterns.yml")
    |> :yamerl_constr.file
  end
end
