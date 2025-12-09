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
    patterns = read_from_yaml()

    simple_put(patterns)

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
  Returns a tuple containing all three pattern lists:
  `{user_agent_patterns, os_patterns, device_patterns}`.
  """
  @spec list() :: {term(), term(), term()}
  def list do
    simple_get()
  end

  defp simple_get do
    :persistent_term.get(key())
  end

  defp simple_put(value) do
    :persistent_term.put(key(), value)
  end

  defp key do
    {__MODULE__, :patterns}
  end
end
