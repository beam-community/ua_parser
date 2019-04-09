defmodule UAParser.Device do
  @moduledoc """
  Device struct and helper methods.
  """

  @doc """
  ## Examples

      iex> device = %UAParser.Device{family: "iPhone"}
      iex> to_string(device)
      "iPhone"

      iex> device = %UAParser.Device{}
      iex> to_string(device)
      "Other"
  """
  defstruct [:brand, :family, :model]
end

defimpl String.Chars, for: UAParser.Device do
  def to_string(%{family: nil}), do: "Other"
  def to_string(%{family: family}), do: family
end
