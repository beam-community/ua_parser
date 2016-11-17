defmodule UserAgentParser.UserAgent do
  @moduledoc """
  User Agent struct and helper methods
  """

  defstruct [:device, :family, :os, :version]

  @doc """
  Display the UserAgent as a string

  # Examples

    iex> version = %UserAgentParser.Version{major: "1", minor: "2", patch: "3", patch_minor: "4"}
    iex> agent = %UserAgentParser.UserAgent{family: "Family", version: version}
    iex> UserAgentParser.UserAgent.to_string(agent)
    "Family 1.2.3.4"

    iex> agent = %UserAgentParser.UserAgent{family: "Family"}
    iex> UserAgentParser.UserAgent.to_string(agent)
    "Family"

    iex> agent = %UserAgentParser.UserAgent{}
    iex> UserAgentParser.UserAgent.to_string(agent)
    "Other"
  """
  def to_string(%{family: family, version: nil}), do: family_name(family)
  def to_string(%{family: family, version: version}), do: "#{family_name(family)} #{version}"

  defp family_name(nil), do: "Other"
  defp family_name(name), do: name
end
