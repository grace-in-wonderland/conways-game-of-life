# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :conways_game_of_life,
  ecto_repos: [ConwaysGameOfLife.Repo]

# Configures the endpoint
config :conways_game_of_life, ConwaysGameOfLifeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EkZZGi0hEdjNJ2mUFZUUe5Drg3V4Xp3S7cnb3ag0Ky0B8aB0IZ4wbyIkWCwsQnx2",
  render_errors: [view: ConwaysGameOfLifeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ConwaysGameOfLife.PubSub,
  live_view: [signing_salt: "T9dphZP1"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
