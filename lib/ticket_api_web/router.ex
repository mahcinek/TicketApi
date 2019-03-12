defmodule TicketApiWeb.Router do
  use TicketApiWeb, :router
  alias TicketApi.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", TicketApiWeb do
    pipe_through [:api, :jwt_authenticated]
  end

  scope "/api/v1", TicketApiWeb do
    pipe_through :api
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end
end
