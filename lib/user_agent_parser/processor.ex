defmodule UserAgentParser.Processor do

  alias UserAgentParser.Storage

  def sanitize(user_agent) do
    safe =
      user_agent
      |> String.trim

    {:ok, safe}
  end

  def parse!(user_agent) do
    {user_agents, os, devices} = Storage.list

  end

  defp search(patterns, string) do
    patterns
    |> Enum.find(fn(regex) -> Regex.match?(regex, string) end)
    |> match
  end

  defp match(nil, _string),
    do: nil

  defp match(matches, string),
    do: Regex.run(matches, string)
end
