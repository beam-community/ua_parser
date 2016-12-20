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
    [family: :device_replacement, brand: :brand_replacement, model: :model_replacement ]
    |> do_replacement({group,match}, %Device{})
  end
  def do_replacement([], _, device), do: device
  def do_replacement([{key,replacement}| replacements],{group,match}, device) do
    replace = Map.get(group, replacement)
    replace =
      match
      |> Enum.with_index
      |> Enum.reduce(replace, fn({_, index}, acc) ->
        replace(acc, index, match)
      end)
    do_replacement(replacements, {group,match}, Map.put(device,key,replace))
  end
end
