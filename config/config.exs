# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ticket_api,
  ecto_repos: [TicketApi.Repo]

# Configures the endpoint
config :ticket_api, TicketApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "r5oUsH/5qaEMo7HXXoCyp+qM1idZuhae5RUrTfEv7LIFOUmAzOR+WiavO6tqXiAQ",
  render_errors: [view: TicketApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: TicketApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Guardian config, for ease of verification secret is visible but should be hidden in env variable
config :ticket_api, TicketApi.Guardian,
       issuer: "TicketApi",
       secret_key: "xPqFkVYs+rR0ex9R3LOemGEKofHuoCQx6knk28W0VtlZ+dZJscVsqtQ41XNPMwGW"

# Rihanna for backgroud job processing
config :rihanna,
  producer_postgres_connection: {Ecto, TicketApi.Repo}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
