use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ticket_api, TicketApiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Faster tests due to less secure hasing
config :bcrypt_elixir, :log_rounds, 4

# Configure your database
config :ticket_api, TicketApi.Repo,
  username: "mpiwek",
  password: "piwek",
  database: "ticket_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
