defmodule TicketApiWeb.Router do
  use TicketApiWeb, :router
  alias TicketApi.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", TicketApiWeb do
    pipe_through [:api, :jwt_authenticated]
    resources "/users", UserController, only: [:delete, :show]
    patch "/users", UserController, :update
    put "/users", UserController, :update
    resources "/tickets", TicketController, only: [:index, :create, :show, :update]
    post "/payments", PaymentController, only: [:index, :show, :create]
  end

  scope "/api/v1", TicketApiWeb do
    pipe_through :api
    resources "/users", UserController, only: [:create]
    resources "/events", EventController, only: [:index, :show]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end
end
