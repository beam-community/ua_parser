defmodule UAParser do
  @moduledoc """
  A fast User Agent parser with a widely used API.
  """

  alias UAParser.{Parser, Storage}

  @doc """
  Parse a user-agent string into structs

  ## Examples

      iex> agent_string = "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Safari/530.17 Skyfire/2.0"
      iex> ua = UAParser.parse(agent_string)
      iex> to_string(ua)
      "Skyfire 2.0"
      iex> to_string(ua.os)
      "Mac OS X 10.5.7"
      iex> to_string(ua.device)
      "Mac"

  """
  def parse(nil), do: parse("")
  def parse(ua), do: parse(ua, default_pattern())
  def parse(ua, pattern), do: Parser.parse(pattern, ua)

  defp default_pattern, do: Storage.list()
end
