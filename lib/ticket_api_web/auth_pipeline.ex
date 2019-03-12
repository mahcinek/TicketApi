defmodule TicketApi.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :ticket_api,
  module: TicketApi.Guardian,
  error_handler: TicketApi.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
