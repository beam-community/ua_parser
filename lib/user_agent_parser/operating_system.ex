defmodule UserAgentParser.OperatingSystem do
  @moduledoc """
  Operating System struct
  """

  @doc """
  # Examples

    iex> version = %UserAgentParser.Version{major: "1", minor: "2"}
    iex> os = %UserAgentParser.OperatingSystem{family: "macOS", version: version}
    iex> to_string(os)
    "macOS 1.2"

    iex> os = %UserAgentParser.OperatingSystem{family: "macOS"}
    iex> to_string(os)
    "macOS"
  """
  defstruct [:family, :version]
end

defimpl String.Chars, for: UserAgentParser.OperatingSystem do
  def to_string(%{family: family, version: version}), do: String.trim("#{family} #{version}")
end
