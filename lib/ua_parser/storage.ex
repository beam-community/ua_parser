defmodule UAParser.Storage do
  @moduledoc """
  Compile time loads regex data. Unfortunatley would require a restart for any pattern update
  """

  alias UAParser.Processor
  {:ok,doc} = (:code.priv_dir(:ua_parser) ++ '/patterns.yml')
      |> to_string
      |> Yomel.decode_file
  data = Processor.process(doc)
  @data data

  def list, do: @data


end
