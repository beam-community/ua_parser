defmodule UAParser.Application do
  use Application

  def start(_type, _args) do
    UAParser.Storage.load_table()

    children = []

    opts = [strategy: :one_for_one, name: UAParser.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
