defmodule UserAgentParser.StorageTest do
  use ExUnit.Case

  test "lists storage contents" do
    result = UserAgentParser.Storage.list

    assert is_tuple(result)
    assert tuple_size(result) == 3
  end
end
