defmodule UAParser.Parser do
  @moduledoc """
  Handle parsing the user-agent string.
  """

  alias UAParser.Parsers.{Device, OperatingSystem, UA}

  @doc """
  Parse a user-agent string given a set of patterns
  """
  def parse({ua_patterns, os_patterns, device_patterns}, user_agent) do
    user_agent
    |> sanitize
    |> parse_os(os_patterns)
    |> parse_device(device_patterns)
    |> parse_user_agent(ua_patterns)
  end

  defp find_and_parse(patterns, user_agent, module) do
    patterns
    |> search(user_agent)
    |> module.parse
  end

  defp match(nil, _string), do: nil
  defp match(group, string) do
    match =
      group
      |> Keyword.fetch!(:regex)
      |> Regex.run(string)

    {group, match}
  end

  defp parse_device({user_agent, acc}, patterns) do
    device = find_and_parse(patterns, user_agent, Device)
    {user_agent, Map.put(acc, :device, device)}
  end

  defp parse_os(user_agent, patterns) do
    os = find_and_parse(patterns, user_agent, OperatingSystem)
    {user_agent, %{os: os}}
  end

  defp parse_user_agent({user_agent, acc}, patterns) do
    patterns
    |> find_and_parse(user_agent, UA)
    |> Map.merge(acc)
  end

  defp sanitize(user_agent), do: String.trim(user_agent)

  defp search(groups, string) do
    groups
    |> Enum.find(fn(group) ->
      group
      |> Keyword.fetch!(:regex)
      |> Regex.match?(string)
    end)
    |> match(string)
  end
end
