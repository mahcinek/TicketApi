defmodule TicketApiWeb.TicketController do
  use TicketApiWeb, :controller

  alias TicketApi.Tick
  alias TicketApi.Auth
  alias TicketApi.Tick.Ticket

  action_fallback TicketApiWeb.FallbackController

  def index(conn, _params) do
    tickets = Auth.list_tickets(Guardian.Plug.current_resource(conn))
    render(conn, "index.json", tickets: tickets)
  end

  def create(conn, %{"ticket" => ticket_params}) do
    ticket_params = ticket_params
                    |> filter_params
                    |> add_user_id(Guardian.Plug.current_resource(conn))
    with {:ok, %Ticket{} = ticket} <- Tick.create_ticket(ticket_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.ticket_path(conn, :show, ticket))
      |> render("show.json", ticket: ticket)
    end
  end

  def show(conn, %{"id" => id}) do
    ticket = Tick.get_ticket!(id)
    render(conn, "show.json", ticket: ticket)
  end

  def update(conn, %{"id" => id, "ticket" => ticket_params}) do
    ticket_params = ticket_params
                    |> filter_params
    with {:ok, ticket: %Ticket{} = ticket} <- get_ticket(Guardian.Plug.current_resource(conn), id) do
      with {:ok, %Ticket{} = ticket} <- Tick.update_ticket(ticket, ticket_params) do
        render(conn, "show.json", ticket: ticket)
      end
    end
  end

  defp add_user_id(ticket_params, user) do
    Map.put(ticket_params, "user_id", user.id)
    |> Map.put("reservation_only", true)
  end

  defp filter_params(ticket_params) do
    Map.drop(ticket_params, [:only_reserved, :paid])
  end

  defp get_ticket(user, article_id) do
    case Auth.get_ticket(user, article_id) do
      {:error,_} ->
        {:error, :forbidden}
      {:ok, ticket} ->
        {:ok, ticket}
    end
  end
end
