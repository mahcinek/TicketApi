defmodule TicketApiWeb.TicketCountView do
use TicketApiWeb, :view
# alias TicketApiWeb.TicketCount

  def render("ticket_count.json", %{ticket_count: ticket_count}) do
    %{
      max_size: ticket_count.max_size,
      size_left: ticket_count.size_left,
      ticket_type: ticket_count.ticket_type.name,
      t_type: ticket_count.ticket_type.t_type,
      price: ticket_count.ticket_type.price
    }
  end

end
