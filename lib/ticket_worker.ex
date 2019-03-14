defmodule TicketApi.TicketWorker do
  alias TicketApi.Tc
  alias TicketApi.Tick

  def perform(reservation_code, ticket_count_id, count) do
    ticket_job(reservation_code, ticket_count_id, count)
  end

  def ticket_job(reservation_code, ticket_count_id, count) do
    ticket = Tick.get_ticket_by_code!(reservation_code)
    if ticket.only_reserved do
      ticket_count = Tc.get_ticket_count!(ticket_count_id)
      Tc.update_ticket_count(ticket_count, %{size_left: ticket_count.size_left + count})
      Tick.delete_ticket(ticket)
    end
  end
end

