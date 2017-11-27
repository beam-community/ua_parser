defmodule UAParser.Storage do
  @moduledoc """
  Load pattern data at compile time. Recompiling the application is necessary after updating the pattern file.
  """

  alias UAParser.Processor

  Application.start(:yamerl)

  data =
    :ua_parser
    |> :code.priv_dir()
    |> Kernel.++('/patterns.yml')
    |> to_string
    |> :yamerl_constr.file([])
    |> Processor.process()

  @data data

  def list, do: @data
end
