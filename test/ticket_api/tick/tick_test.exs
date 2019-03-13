defmodule TicketApi.TickTest do
  use TicketApi.DataCase

  alias TicketApi.Tick

  describe "tickets" do
    alias TicketApi.Tick.Ticket

    @valid_attrs %{first_name: "some first_name", last_name: "some last_name", only_reserved: true, paid: true, reservation_code: "some reservation_code"}
    @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name", only_reserved: false, paid: false, reservation_code: "some updated reservation_code"}
    @invalid_attrs %{first_name: nil, last_name: nil, only_reserved: nil, paid: nil, reservation_code: nil}

    def ticket_fixture(attrs \\ %{}) do
      {:ok, ticket} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tick.create_ticket()

      ticket
    end

    test "list_tickets/0 returns all tickets" do
      ticket = ticket_fixture()
      assert Tick.list_tickets() == [ticket]
    end

    test "get_ticket!/1 returns the ticket with given id" do
      ticket = ticket_fixture()
      assert Tick.get_ticket!(ticket.id) == ticket
    end

    test "create_ticket/1 with valid data creates a ticket" do
      assert {:ok, %Ticket{} = ticket} = Tick.create_ticket(@valid_attrs)
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
end
