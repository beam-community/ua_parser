defmodule UAParser.Storage do
  @moduledoc """
  Load pattern data at boot time and store it in persistent_term.
  """

  alias UAParser.Processor

  Application.start(:yamerl)

  @doc """
  Loads the user agent, operating system, and device patterns from the YAML file
  into persistent_term.

  Returns `:ok` on success.
  """
  @spec load_table() :: :ok
  def load_table do
    {ua_patterns, os_patterns, device_patterns} = read_from_yaml()

    simple_put(:ua_patterns, ua_patterns)
    simple_put(:os_patterns, os_patterns)
    simple_put(:device_patterns, device_patterns)

    :ok
  end

  defp read_from_yaml do
    :ua_parser
    |> :code.priv_dir()
    |> Kernel.++(~c"/patterns.yml")
    |> :yamerl_constr.file([])
    |> Processor.process()
  end

  @doc """
  Retrieves the list of user agent patterns from persistent_term.
  """
  @spec ua_patterns() :: term()
  def ua_patterns, do: simple_get(:ua_patterns)

  @doc """
  Retrieves the list of operating system patterns from persistent_term.
  """
  @spec os_patterns() :: term()
  def os_patterns, do: simple_get(:os_patterns)

  @doc """
  Retrieves the list of device patterns from persistent_term.
  """
  @spec device_patterns() :: term()
  def device_patterns, do: simple_get(:device_patterns)

  @doc """
  Returns a tuple containing all three pattern lists:
  `{user_agent_patterns, os_patterns, device_patterns}`.
  """
  @spec list() :: {term(), term(), term()}
  def list do
    {ua_patterns(), os_patterns(), device_patterns()}
  end

  defp simple_get(key) do
    key
    |> key()
    |> :persistent_term.get()
  end

  defp simple_put(key, value) do
    key
    |> key()
    |> :persistent_term.put(value)
  end

  defp key(name) do
    {__MODULE__, name}
  end
end
