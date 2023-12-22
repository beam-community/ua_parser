defmodule UAParser.ProcessorTest do
  use ExUnit.Case

  alias UAParser.Processor

  test "converts yaml document into data structure" do
    test_data =
      File.cwd!()
      |> Path.join("test/fixtures/patterns.yml")
      |> :yamerl_constr.file()

    assert {[
              [
                regex: %Regex{}
              ]
            ],
            [
              [
                regex: %Regex{},
                os_replacement: "Mac OS X"
              ]
            ],
            [
              [
                regex: %Regex{},
                device_replacement: "$1",
                brand_replacement: "Apple",
                model_replacement: "$1"
              ]
            ]} = Processor.process(test_data)
  end
end
