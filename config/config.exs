use Mix.Config

config :user_agent_parser,
  patterns: "./patterns.yml"

import_config "#{Mix.env}.exs"
