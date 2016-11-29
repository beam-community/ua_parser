defmodule UAParser.StorageTest do
  use ExUnit.Case

  test "lists storage contents" do
    result = UAParser.Storage.list

    assert is_tuple(result)
    assert tuple_size(result) == 3
  end
end
