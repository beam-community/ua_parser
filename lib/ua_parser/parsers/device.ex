defmodule UAParser.Parsers.Device do
  @moduledoc """
  A parser module representing the device & its relevent information
  of a user agent.
  """

  @behaviour UAParser.Parsers.Base

  import UAParser.Parsers.Base

  alias UAParser.Device

  @replacements [brand: :brand_replacement, family: :device_replacement, model: :model_replacement]

  def parse(nil), do: %Device{}
  def parse({group, match}),
    do: do_replacement(@replacements, {group, match}, %Device{})

  def do_replacement([], _, device), do: device
  def do_replacement([{key, replacement}| replacements], {group, match}, device) do
    replace = Keyword.get(group, replacement)
    replace =
      match
      |> Enum.with_index
      |> Enum.reduce(replace, fn({_, index}, acc) ->
        replace(acc, index, match)
      end)
    do_replacement(replacements, {group, match}, Map.put(device, key, replace))
  end
end
