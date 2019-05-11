# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :newzjunky,
  ecto_repos: [Newzjunky.Repo]

# Configures the endpoint
config :newzjunky, NewzjunkyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Mur3sfa21zV5T3SDCqQLei0o+DM8bNWoUuDFfoi/fyL3powe4eMBB+1TwwTvCH3e",
  render_errors: [view: NewzjunkyWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Newzjunky.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# Guardian config
config :newzjunky, Newzjunky.Guardian,
  issuer: "newzjunky",
  secret_key: "OPkyLjzH372I0DLejM2NVnBdXZLuZbBSoIpr2+085qux5Qy3mbzJamyCpC2Pe6ox"
