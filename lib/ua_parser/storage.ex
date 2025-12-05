defmodule UAParser.Storage do
  @moduledoc """
  Load pattern data at boot time and store it in ETS.
  """

  alias UAParser.Processor

  Application.start(:yamerl)

  @table_name String.to_atom("ua_patterns_#{Mix.Project.config()[:version]}")

  @doc """
  Loads the user agent, operating system, and device patterns from the YAML file
  into an ETS table at compile time.

  Returns `:ok` on success.
  """
  @spec load_table() :: :ok
  def load_table() do
    table = :ets.new(@table_name, [:bag, :named_table])

    {ua_patterns, os_patterns, device_patterns} = read_from_yaml()

    :ets.insert(table, {:ua_patterns, ua_patterns})
    :ets.insert(table, {:os_patterns, os_patterns})
    :ets.insert(table, {:device_patterns, device_patterns})

    :ok
  end

  defp read_from_yaml() do
    :ua_parser
    |> :code.priv_dir()
    |> Kernel.++(~c"/patterns.yml")
    |> :yamerl_constr.file([])
    |> Processor.process()
  end

  @doc """
  Retrieves the list of user agent patterns from the ETS table.
  """
  @spec ua_patterns() :: term()
  def ua_patterns(), do: simple_lookup(:ua_patterns)

  @doc """
  Retrieves the list of operating system patterns from the ETS table.
  """
  @spec os_patterns() :: term()
  def os_patterns(), do: simple_lookup(:os_patterns)

  @doc """
  Retrieves the list of device patterns from the ETS table.
  """
  @spec device_patterns() :: term()
  def device_patterns(), do: simple_lookup(:device_patterns)

  @doc """
  Returns a tuple containing all three pattern lists:
  `{user_agent_patterns, os_patterns, device_patterns}`.
  """
  @spec list() :: {term(), term(), term()}
  def list() do
    {ua_patterns(), os_patterns(), device_patterns()}
  end

  defp simple_lookup(key) do
    :ets.lookup(@table_name, key) |> hd |> elem(1)
  end
end
