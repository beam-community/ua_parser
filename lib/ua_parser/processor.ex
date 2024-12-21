defmodule UAParser.Processor do
  @moduledoc """
  Prepare a raw YAML document for consumption by the parser by
  converting charlists into strings and compiling our patterns.
  """

  @doc """
  Process a document into Elixir keyword lists and compiled patterns.
  """
  def process(document) do
    document
    |> extract
    |> convert
    |> compile
  end

  defp atom_key(key) do
    key
    |> String.Chars.to_string()
    # credo:disable-for-next-line Credo.Check.Warning.UnsafeToAtom
    |> String.to_atom()
  end

  defp compile(groups) do
    # result: {user_agents, os, devices}
    groups
    |> Enum.map(&compile_groups/1)
    |> :erlang.list_to_tuple()
  end

  defp compile_group(group) do
    pattern =
      group
      |> Keyword.fetch!(:regex)
      |> Regex.compile!()

    Keyword.put(group, :regex, pattern)
  end

  defp compile_groups(groups), do: Enum.map(groups, &compile_group/1)

  defp convert([]), do: []

  defp convert([head | tail]) do
    result = Enum.map(head, &to_keyword/1)
    [result | convert(tail)]
  end

  defp extract([document | _]) do
    [{~c"user_agent_parsers", user_agents}, {~c"os_parsers", os}, {~c"device_parsers", devices}] = document

    [user_agents, os, devices]
  end

  defp to_keyword([]), do: []

  defp to_keyword([{key, value} | tails]) do
    keyword = {atom_key(key), String.Chars.to_string(value)}
    [keyword | to_keyword(tails)]
  end
end
