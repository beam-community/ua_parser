defmodule UserAgentParser.Version do
  @moduledoc """
  Version struct and helper methods
  """

  @doc """
  # Examples

    iex> version = %UserAgentParser.Version{major: "1", minor: "2", patch: "3", patch_minor: "4"}
    iex> to_string(version)
    "1.2.3.4"

    iex> version = %UserAgentParser.Version{major: "1", minor: "2", patch: "3"}
    iex> to_string(version)
    "1.2.3"

    iex> version = %UserAgentParser.Version{major: "1", minor: "2"}
    iex> to_string(version)
    "1.2"

    iex> version = %UserAgentParser.Version{major: "1"}
    iex> to_string(version)
    "1"
  """
  defstruct [:major, :minor, :patch, :patch_minor]
end

defimpl String.Chars, for: UserAgentParser.Version do
  def to_string(%{major: major, minor: minor, patch: patch, patch_minor: patch_minor}) do
    [major, minor, patch, patch_minor]
    |> Enum.reject(&is_nil/1)
    |> Enum.join(".")
  end
end
