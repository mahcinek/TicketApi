defmodule TicketApi.Repo do
  use Ecto.Repo,
    otp_app: :ticket_api,
    adapter: Ecto.Adapters.Postgres
end
