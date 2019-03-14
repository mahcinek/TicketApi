defmodule TicketApi.TtTest do
  use TicketApi.DataCase

  alias TicketApi.Tt

  describe "ticket_types" do
    alias TicketApi.Tt.TicketType

    @valid_attrs %{name: "some name", t_type: "altogether", price: 40}
    @update_attrs %{name: "some updated name", t_type: "multiple"}
    @invalid_attrs %{name: nil, t_type: nil}

    def ticket_type_fixture(attrs \\ %{}) do
      {:ok, ticket_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tt.create_ticket_type()

      ticket_type
    end

    test "list_ticket_types/0 returns all ticket_types" do
      ticket_type = ticket_type_fixture()
      assert Tt.list_ticket_types() == [ticket_type]
    end

    test "get_ticket_type!/1 returns the ticket_type with given id" do
      ticket_type = ticket_type_fixture()
      assert Tt.get_ticket_type!(ticket_type.id) == ticket_type
    end

    test "create_ticket_type/1 with valid data creates a ticket_type" do
      assert {:ok, %TicketType{} = ticket_type} = Tt.create_ticket_type(@valid_attrs)
      assert ticket_type.name == "some name"
      assert ticket_type.t_type == "altogether"
    end

    test "create_ticket_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tt.create_ticket_type(@invalid_attrs)
    end

    test "update_ticket_type/2 with valid data updates the ticket_type" do
      ticket_type = ticket_type_fixture()
      assert {:ok, %TicketType{} = ticket_type} = Tt.update_ticket_type(ticket_type, @update_attrs)
      assert ticket_type.name == "some updated name"
      assert ticket_type.t_type == "multiple"
    end

    test "update_ticket_type/2 with invalid data returns error changeset" do
      ticket_type = ticket_type_fixture()
      assert {:error, %Ecto.Changeset{}} = Tt.update_ticket_type(ticket_type, @invalid_attrs)
      assert ticket_type == Tt.get_ticket_type!(ticket_type.id)
    end

    test "delete_ticket_type/1 deletes the ticket_type" do
      ticket_type = ticket_type_fixture()
      assert {:ok, %TicketType{}} = Tt.delete_ticket_type(ticket_type)
      assert_raise Ecto.NoResultsError, fn -> Tt.get_ticket_type!(ticket_type.id) end
    end

    test "change_ticket_type/1 returns a ticket_type changeset" do
      ticket_type = ticket_type_fixture()
      assert %Ecto.Changeset{} = Tt.change_ticket_type(ticket_type)
    end
  end
end
