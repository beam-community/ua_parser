defmodule UserAgentParser.Processor do
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
      |> Keyword.fetch!(:regex)
      |> Regex.compile!

    Keyword.put(group, :regex, pattern)
  end

  defp compile_groups(groups), do: Enum.map(groups, &compile_group/1)

  defp convert([]), do: []
  defp convert([head|tail]) do
    result = Enum.map(head, &to_keyword/1)
    [result|convert(tail)]
  end

  defp extract([document|_]) do
    [{'user_agent_parsers', user_agents}, {'os_parsers', os}, {'device_parsers', devices}] = document

    [user_agents, os, devices]
  end

  defp to_keyword([]), do: []
  defp to_keyword([{key, value}|tails]) do
    keyword = {atom_key(key), String.Chars.to_string(value)}
    [keyword | to_keyword(tails)]
  end

  defp to_tuple(values, tuple \\ {})
  defp to_tuple([], tuple), do: tuple
  defp to_tuple([head|tail], tuple) do
    tuple  = Tuple.append(tuple, head)
    to_tuple(tail, tuple)
  end
end
