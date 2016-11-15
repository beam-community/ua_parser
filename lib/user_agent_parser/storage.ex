defmodule UserAgentParser.Storage do
  @moduledoc """
  Storage of User-Agent regular expressions
  """

  use GenServer

  alias __MODULE__, as: Storage
  alias UserAgentParser.Processor

  @pattern_file Application.get_env(:user_agent_parser, :patterns)

  @doc """
  Start our GenServer.
  """
  def start_link(opts \\ []) do
    GenServer.start_link(Storage, opts, name: Storage)
  end

  @doc """
  Initialize storage
  """
  def init(opts), do: load_patterns(opts)

  @doc """
  Look for a matching User-Agent
  """
  def handle_call(:list, _from, opts),
    do: {:reply, opts[:data], opts}

  @doc """
  """
  def list, do: GenServer.call(Storage, :list)

  defp load_patterns(opts) do
    file = Keyword.get(opts, :pattern_file, @pattern_file)

    data =
      file
      |> :yamerl_constr.file
      |> Processor.process

    opts =
      opts
      |> Keyword.put(:data, data)

    {:ok, opts}
  end
end
