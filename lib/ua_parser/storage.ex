defmodule UAParser.Storage do
  @moduledoc """
  Load pattern data at compile time. Recompiling the application is necessary
  after updating the pattern file.
  """

  alias UAParser.Processor

  Application.start(:yamerl)

  def list do
    :ua_parser
    |> :code.priv_dir()
    |> Kernel.++(~c"/patterns.yml")
    |> :yamerl_constr.file([])
    |> Processor.process()
  end
end
