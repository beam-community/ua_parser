defmodule UserAgentParser do
  @moduledoc """
  """

  use Application

  alias UserAgentParser.{Parser, Storage}

  @doc false
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Storage, []),
    ]

    opts = [strategy: :one_for_one, name: UserAgentParser.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc """
  Parse a user-agent string into structs

  # Examples

    iex> agent_string = "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Safari/530.17 Skyfire/2.0"
    iex> user_agent = UserAgentParser.parse(agent_string)
    iex> to_string(user_agent)
    "Skyfire 2.0"
    iex> to_string(user_agent.os)
    "Mac OS X 10.5.7"
    iex> to_string(user_agent.device)
    "Other"
  """
  def parse(user_agent), do: Parser.parse(pattern, user_agent)

  defp pattern, do: Storage.list
end
