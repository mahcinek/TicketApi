defmodule TicketApi.EvTest do
  use TicketApi.DataCase

  alias TicketApi.Ev

  describe "events" do
    alias TicketApi.Ev.Event

    @valid_attrs %{adress: "some adress", name: "some name", start_at: "2010-04-17T14:00:00Z"}
    @update_attrs %{adress: "some updated adress", name: "some updated name", start_at: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{adress: nil, name: nil, start_at: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ev.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Ev.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Ev.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Ev.create_event(@valid_attrs)
      assert event.adress == "some adress"
      assert event.name == "some name"
      assert event.start_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ev.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, %Event{} = event} = Ev.update_event(event, @update_attrs)
      assert event.adress == "some updated adress"
      assert event.name == "some updated name"
      assert event.start_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Ev.update_event(event, @invalid_attrs)
      assert event == Ev.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Ev.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Ev.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Ev.change_event(event)
    end
  end
end
