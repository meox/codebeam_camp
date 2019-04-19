# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :codebeam_camp,
  ecto_repos: [CodebeamCamp.Repo]

# Configures the endpoint
config :codebeam_camp, CodebeamCampWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OgyFpHvB4lnrtT95tlgernyDElTt4kDosQEGZgzbd9FLn29NPEpthjHWCxz40TUz",
  render_errors: [view: CodebeamCampWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CodebeamCamp.PubSub, adapter: Phoenix.PubSub.PG2]

config :codebeam_camp, CodebeamCampWeb.Endpoint,
  live_view: [
    signing_salt: "h49p0NkDH9lLo614f9mObz8ahPioq1PY"
  ]

config :codebeam_camp, CodebeamCamp.Mailer,
  adapter: Bamboo.SendGridAdapter,
  api_key: System.get_env("SENDGRID_API_KEY")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
