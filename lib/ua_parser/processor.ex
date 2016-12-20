defmodule UAParser.Processor do
  @moduledoc """
  Prepare a raw YAML document for consumption by the parser by
  converting charlists into strings and compiling our patterns.
  """

  @doc """
  Process a document into Elixir keyword lists and compiled patterns
  """
  def process(document) do
    document
    |> extract
    |> convert
    |> compile
  end

  defp atom_key(key) do
    key
    |> String.Chars.to_string
    |> String.to_atom
  end

  defp compile(groups) do
    groups
    |> Enum.map(&compile_groups/1)
    |> to_tuple # result: {user_agents, os, devices}
  end

  defp compile_group(group) do
    pattern =
      group
      |> Map.fetch!(:regex)
      |> Regex.compile!

    Map.put(group, :regex, pattern)
  end

  defp compile_groups(groups), do: Enum.map(groups, &compile_group/1)

  defp convert([]), do: []
  defp convert([head|tail]) do
    result = to_atoms(head)
    [result|convert(tail)]
  end

  defp extract([document]) do

    %{"user_agent_parsers"=>user_agents, "os_parsers"=> os, "device_parsers"=>devices} = document

    [user_agents, os, devices]
  end

  defp to_atoms([]), do: []
  defp to_atoms([head|tails]) do

    [Enum.map(head, fn {k,v}-> {String.to_atom(k),v} end)|> Enum.into(%{}) | to_atoms(tails)]
  end

  defp to_tuple(values, tuple \\ {})
  defp to_tuple([], tuple), do: tuple
  defp to_tuple([head|tail], tuple) do
    tuple  = Tuple.append(tuple, head)
    to_tuple(tail, tuple)
  end
end
