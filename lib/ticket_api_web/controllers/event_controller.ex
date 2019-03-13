defmodule TicketApiWeb.EventController do
  use TicketApiWeb, :controller

  alias TicketApi.Ev
  # alias TicketApi.Ev.Event

  action_fallback TicketApiWeb.FallbackController

  def index(conn, _params) do
    events = Ev.list_events_with_tickets_avabile()
    render(conn, "index.json", events: events)
  end

  # Some of the methods are commented because they are not implemented but could be needed if there was admin api
  # def create(conn, %{"event" => event_params}) do
  #   with {:ok, %Event{} = event} <- Ev.create_event(event_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", Routes.event_path(conn, :show, event))
  #     |> render("show.json", event: event)
  #   end
  # end

  def show(conn, %{"id" => id}) do
    event = Ev.get_event!(id)
    render(conn, "show.json", event: event)
  end

  # def update(conn, %{"id" => id, "event" => event_params}) do
  #   event = Ev.get_event!(id)

  #   with {:ok, %Event{} = event} <- Ev.update_event(event, event_params) do
  #     render(conn, "show.json", event: event)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   event = Ev.get_event!(id)

  #   with {:ok, %Event{}} <- Ev.delete_event(event) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
