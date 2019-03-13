defmodule TicketApiWeb.EventView do
  use TicketApiWeb, :view
  alias TicketApiWeb.EventView
  alias TicketApiWeb.TicketCountView

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{id: event.id,
      adress: event.adress,
      name: event.name,
      start_at: event.start_at,
      ticket_counts: render_many(event.ticket_counts, TicketCountView, "ticket_count.json")
    }
  end


end
