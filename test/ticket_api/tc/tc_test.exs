defmodule TicketApi.TcTest do
  use TicketApi.DataCase

  alias TicketApi.Tc

  describe "ticket_counts" do
    alias TicketApi.Tc.TicketCount

    @valid_attrs %{max_size: 42, size_left: 42}
    @update_attrs %{max_size: 43, size_left: 43}
    @invalid_attrs %{max_size: nil, size_left: nil}

    def ticket_count_fixture(attrs \\ %{}) do
      {:ok, ticket_count} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tc.create_ticket_count()

      ticket_count
    end

    test "list_ticket_counts/0 returns all ticket_counts" do
      ticket_count = ticket_count_fixture()
      assert Tc.list_ticket_counts() == [ticket_count]
    end

    test "get_ticket_count!/1 returns the ticket_count with given id" do
      ticket_count = ticket_count_fixture()
      assert Tc.get_ticket_count!(ticket_count.id) == ticket_count
    end

    test "create_ticket_count/1 with valid data creates a ticket_count" do
      assert {:ok, %TicketCount{} = ticket_count} = Tc.create_ticket_count(@valid_attrs)
      assert ticket_count.max_size == 42
      assert ticket_count.size_left == 42
    end

    test "create_ticket_count/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tc.create_ticket_count(@invalid_attrs)
    end

    test "update_ticket_count/2 with valid data updates the ticket_count" do
      ticket_count = ticket_count_fixture()
      assert {:ok, %TicketCount{} = ticket_count} = Tc.update_ticket_count(ticket_count, @update_attrs)
      assert ticket_count.max_size == 43
      assert ticket_count.size_left == 43
    end

    test "update_ticket_count/2 with invalid data returns error changeset" do
      ticket_count = ticket_count_fixture()
      assert {:error, %Ecto.Changeset{}} = Tc.update_ticket_count(ticket_count, @invalid_attrs)
      assert ticket_count == Tc.get_ticket_count!(ticket_count.id)
    end

    test "delete_ticket_count/1 deletes the ticket_count" do
      ticket_count = ticket_count_fixture()
      assert {:ok, %TicketCount{}} = Tc.delete_ticket_count(ticket_count)
      assert_raise Ecto.NoResultsError, fn -> Tc.get_ticket_count!(ticket_count.id) end
    end

    test "change_ticket_count/1 returns a ticket_count changeset" do
      ticket_count = ticket_count_fixture()
      assert %Ecto.Changeset{} = Tc.change_ticket_count(ticket_count)
    end
  end
end
