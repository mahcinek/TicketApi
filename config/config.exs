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

# Exq for backgroud job processing
config :exq,
  name: Exq,
  host: "127.0.0.1",
  port: 6379,
  namespace: "exq",
  concurrency: 10,
  start_on_application: false,
  queues: ["default"],
  poll_timeout: 50,
  scheduler_poll_timeout: 200,
  scheduler_enable: true,
  max_retries: 25,
  shutdown_timeout: 50000,
  json_library: Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
