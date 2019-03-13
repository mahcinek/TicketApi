defmodule TicketApiWeb.TicketView do
  use TicketApiWeb, :view
  alias TicketApiWeb.TicketView

  def render("index.json", %{tickets: tickets}) do
    %{data: render_many(tickets, TicketView, "ticket.json")}
  end

  def render("show.json", %{ticket: ticket}) do
    %{data: render_one(ticket, TicketView, "ticket.json")}
  end

  def render("ticket.json", %{ticket: ticket}) do
    %{id: ticket.id,
      first_name: ticket.first_name,
      last_name: ticket.last_name,
      only_reserved: ticket.only_reserved,
      paid: ticket.paid,
      reservation_code: ticket.reservation_code}
  end
end
