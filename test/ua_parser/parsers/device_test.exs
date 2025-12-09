defmodule UAParser.Parsers.DeviceTest do
  use ExUnit.Case

  alias UAParser.{Device, Storage}
  alias UAParser.Parsers.Device, as: Parser

  test "parses device information" do
    {_, _, [pattern | _]} = Storage.list()

    result = Parser.parse({pattern, ["iPod;", "iPod"]})
    assert %Device{family: "Spider", brand: "Spider", model: "Smartphone"} == result
  end
end
