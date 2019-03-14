defmodule TicketApi.TickTest do
  use TicketApi.DataCase

  alias TicketApi.Tick
  import TicketApi.Factory

  describe "tickets" do
    alias TicketApi.Tick.Ticket

    def valid_attrs do
      %{first_name: "some first_name", last_name: "some last_name", only_reserved: true, paid: true, reservation_code: "some reservation_code", count: 2}
    end
    @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name", only_reserved: false, paid: false, reservation_code: "some updated reservation_code"}
    @invalid_attrs %{first_name: nil, last_name: nil, only_reserved: nil, paid: nil, reservation_code: nil, count: nil, event_id: nil, ticket_type_id: nil}

    def ticket_fixture(attrs \\ %{}) do
      attrs = gen_vars
      {:ok, ticket} =
        attrs
        |> Enum.into(attrs)
        |> Tick.create_ticket()
      ticket
    end

    test "list_tickets/0 returns all tickets" do
      ticket = ticket_fixture()
      assert Enum.member?(Tick.list_tickets(), ticket)
    end

    test "get_ticket!/1 returns the ticket with given id" do
      ticket = ticket_fixture()
      assert Tick.get_ticket!(ticket.id) == ticket
    end

    test "create_ticket/1 with valid data creates a ticket" do
      assert {:ok, %Ticket{} = ticket} = Tick.create_ticket(gen_vars)
      assert ticket.first_name == "some first_name"
      assert ticket.last_name == "some last_name"
      assert ticket.only_reserved == true
      assert ticket.paid == true
    end

    test "create_ticket/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tick.create_ticket(@invalid_attrs)
    end

    test "update_ticket/2 with valid data updates the ticket" do
      ticket = ticket_fixture()
      assert {:ok, %Ticket{} = ticket} = Tick.update_ticket(ticket, @update_attrs)
      assert ticket.first_name == "some updated first_name"
      assert ticket.last_name == "some updated last_name"
      assert ticket.only_reserved == false
      assert ticket.paid == false
    end

    test "update_ticket/2 with invalid data returns error changeset" do
      ticket = ticket_fixture()
      assert {:error, %Ecto.Changeset{}} = Tick.update_ticket(ticket, @invalid_attrs)
      assert ticket == Tick.get_ticket!(ticket.id)
    end

    test "delete_ticket/1 deletes the ticket" do
      ticket = ticket_fixture()
      assert {:ok, %Ticket{}} = Tick.delete_ticket(ticket)
      assert_raise Ecto.NoResultsError, fn -> Tick.get_ticket!(ticket.id) end
    end

    test "change_ticket/1 returns a ticket changeset" do
      ticket = ticket_fixture()
      assert %Ecto.Changeset{} = Tick.change_ticket(ticket)
    end
  end

  defp c_ticket do
    ticket = insert(:ticket) |>Repo.preload([ticket_type: [:ticket_counts]])
    TicketApi.Tc.update_ticket_count(List.first(ticket.ticket_type.ticket_counts), %{event_id: ticket.event_id})
    ticket
  end

  defp gen_vars do
    tick = c_ticket
    Map.put(valid_attrs, :event_id, tick.event_id)
                |> Map.put(:ticket_type_id, tick.ticket_type_id)
  end
end
