defmodule UAParser do
  @moduledoc false

  use Application

  alias UAParser.{Parser, Storage}

  @doc false
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Storage, []),
    ]

    opts = [strategy: :one_for_one, name: UAParser.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc """
  Parse a user-agent string into structs

  # Examples

    iex> agent_string = "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Safari/530.17 Skyfire/2.0"
    iex> ua = UAParser.parse(agent_string)
    iex> to_string(ua)
    "Skyfire 2.0"
    iex> to_string(ua.os)
    "Mac OS X 10.5.7"
    iex> to_string(ua.device)
    "Other"
  """
  def parse(ua), do: Parser.parse(pattern, ua)

  defp pattern, do: Storage.list
end
