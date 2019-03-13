defmodule TicketApiWeb.UserController do
  use TicketApiWeb, :controller

  alias TicketApi.Auth
  alias TicketApi.Auth.User

  action_fallback TicketApiWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Auth.create_user(user_params) do
      case Auth.create_token(user) do
        {:ok, token} ->
          conn
          |> put_status(:created)
          |> put_resp_header("location", Routes.user_path(conn, :show, user))
          |> render("create.json", user: user, token: token)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    user = Auth.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"user" => user_params}) do
    user = Guardian.Plug.current_resource(conn)
    with {:ok, %User{} = user} <- Auth.update_user(user, user_params) do

      render(conn, "show.json", user: user)
    end
  end

end
