defmodule UAParser.UA do
  @moduledoc """
  User Agent struct and helper methods.
  """

  @type t :: %__MODULE__{
          device: String.t(),
          family: String.t(),
          os: String.t(),
          version: String.t()
        }

  @doc """
  Display the UA as a string

  ## Examples

      iex> version = %UAParser.Version{major: "1", minor: "2", patch: "3", patch_minor: "4"}
      iex> agent = %UAParser.UA{family: "Family", version: version}
      iex> to_string(agent)
      "Family 1.2.3.4"

      iex> agent = %UAParser.UA{family: "Family"}
      iex> to_string(agent)
      "Family"

      iex> agent = %UAParser.UA{}
      iex> to_string(agent)
      "Other"
  """

  defstruct [:device, :family, :os, :version]
end

defimpl String.Chars, for: UAParser.UA do
  def to_string(%{family: family, version: nil}), do: family_name(family)
  def to_string(%{family: family, version: version}), do: "#{family_name(family)} #{version}"

  defp family_name(nil), do: "Other"
  defp family_name(name), do: name
end
