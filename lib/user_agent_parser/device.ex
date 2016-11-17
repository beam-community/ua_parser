defmodule UserAgentParser.Device do
  @moduledoc """
  Device struct and helper methods
  """

  @doc """
  # Examples

    iex> device = %UserAgentParser.Device{family: "iPhone"}
    iex> to_string(device)
    "iPhone"

    iex> device = %UserAgentParser.Device{}
    iex> to_string(device)
    "Other"
  """
  defstruct [:family]
end

defimpl String.Chars, for: UserAgentParser.Device do
  def to_string(%{family: nil}), do: "Other"
  def to_string(%{family: family}), do: family
end
