defmodule UAParser.OperatingSystem do
  @moduledoc """
  A module representing an operating System struct.
  """

  @doc """
  ## Examples

      iex> version = %UAParser.Version{major: "1", minor: "2"}
      iex> os = %UAParser.OperatingSystem{family: "macOS", version: version}
      iex> to_string(os)
      "macOS 1.2"

      iex> os = %UAParser.OperatingSystem{family: "macOS"}
      iex> to_string(os)
      "macOS"
  """
  defstruct [:family, :version]
end

defimpl String.Chars, for: UAParser.OperatingSystem do
  def to_string(%{family: family, version: version}), do: String.trim("#{family} #{version}")
end
