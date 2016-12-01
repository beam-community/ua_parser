defmodule UAParser.Parsers.Device do
  @moduledoc """
  A parser module representing the device & its relevent information
  of a user agent.
  """

  alias UAParser.{Device, Parsers.Base}

  import Base
  @behaviour Base

  def parse(nil), do: %Device{}
  def parse({group, match}) do
    family = Keyword.get(group, :device_replacement)

    family =
      match
      |> Enum.with_index
      |> Enum.reduce(family, fn({_, index}, acc) ->
        replace(acc, index, match)
      end)

    %Device{family: family}
  end
end
