# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :example,
  ecto_repos: [Example.Repo]

# Configures the endpoint
config :example, Example.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HmlZQvShc7xVDBnWzBxHQ2dLYOXfsW10xZDG/mXRio7Xy54uf8w9N+/X+HlhQ7oO",
  render_errors: [view: Example.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Example.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
