defmodule TicketApiWeb.EventControllerTest do
  use TicketApiWeb.ConnCase

  # alias TicketApi.Ev
  # alias TicketApi.Ev.Event
  import TicketApi.Factory  # @create_attrs %{
  #   adress: "some adress",
  #   name: "some name",
  #   start_at: "2010-04-17T14:00:00Z"
  # }
  # @update_attrs %{
  #   adress: "some updated adress",
  #   name: "some updated name",
  #   start_at: "2011-05-18T15:01:01Z"
  # }
  # @invalid_attrs %{adress: nil, name: nil, start_at: nil}

  # @create_attrs %{
  #   adress: "some adress",
  #   name: "some name",
  #   start_at: "2010-04-17T14:00:00Z"
  # }
  # @update_attrs %{
  #   adress: "some updated adress",
  #   name: "some updated name",
  #   start_at: "2011-05-18T15:01:01Z"
  # }
  # @invalid_attrs %{adress: nil, name: nil, start_at: nil}

  describe "index" do
    setup [:create_event]

    test "lists all events", %{conn: conn} do
      conn = get(conn, Routes.event_path(conn, :index))
      assert json_response(conn, 200)["data"] !== []
    end
  end

  defp create_event(conn) do
    insert(:event)
    conn
  end


end
