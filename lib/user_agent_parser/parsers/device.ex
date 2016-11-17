defmodule UserAgentParser.Parsers.Device do
  alias UserAgentParser.{Device, Parsers.Base}

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
