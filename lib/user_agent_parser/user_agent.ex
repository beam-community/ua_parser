defmodule UserAgentParser.UserAgent do
  @moduledoc """
  User Agent struct and helper methods
  """

  @doc """
  Display the UserAgent as a string

  # Examples

    iex> version = %UserAgentParser.Version{major: "1", minor: "2", patch: "3", patch_minor: "4"}
    iex> agent = %UserAgentParser.UserAgent{family: "Family", version: version}
    iex> to_string(agent)
    "Family 1.2.3.4"

    iex> agent = %UserAgentParser.UserAgent{family: "Family"}
    iex> to_string(agent)
    "Family"

    iex> agent = %UserAgentParser.UserAgent{}
    iex> to_string(agent)
    "Other"
  """

  defstruct [:device, :family, :os, :version]
end

defimpl String.Chars, for: UserAgentParser.UserAgent do
  def to_string(%{family: family, version: nil}), do: family_name(family)
  def to_string(%{family: family, version: version}), do: "#{family_name(family)} #{version}"

  defp family_name(nil), do: "Other"
  defp family_name(name), do: name
end
