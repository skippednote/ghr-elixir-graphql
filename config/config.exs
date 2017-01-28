# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :greenHR,
  ecto_repos: [GreenHR.Repo]

# Configures the endpoint
config :greenHR, GreenHR.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/fdOR9nLNaspXX7ihGh18A6+lOJ5z0wKj5HWJTSfnD7IE+YRra2WCnJHAX2iEj5a",
  render_errors: [view: GreenHR.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GreenHR.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
