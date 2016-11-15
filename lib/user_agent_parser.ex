defmodule UserAgentParser do
  use Application

  alias UserAgentParser.Storage

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Storage, []),
    ]

    opts = [strategy: :one_for_one, name: UserAgentParser.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def parse(user_agent) do
    parsed =
      user_agent
      |> Processor.sanitize
      |> Processor.parse!

    {:ok, parsed}
  end
end
