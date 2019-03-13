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

  def show(conn, %{"id" => id}) do
    ticket = Tick.get_ticket!(id)
    render(conn, "show.json", ticket: ticket)
  end

  def update(conn, %{"id" => id, "ticket" => ticket_params}) do
    ticket_params = Map.drop(ticket_params, [:only_reserved, :paid])
    with {:ok, ticket: %Ticket{} = ticket} <- get_ticket(Guardian.Plug.current_resource(conn), id) do
      with {:ok, %Ticket{} = ticket} <- Tick.update_ticket(ticket, ticket_params) do
        render(conn, "show.json", ticket: ticket)
      end
    end
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
