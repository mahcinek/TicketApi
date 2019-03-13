defmodule TicketApiWeb.TicketControllerTest do
  use TicketApiWeb.ConnCase

  alias TicketApi.Auth
  alias TicketApi.Tick.Ticket
  import TicketApi.Factory

  @create_attrs %{
    first_name: "some first_name",
    last_name: "some last_name"
  }
  @update_attrs %{
    first_name: "some updated first_name",
    last_name: "some updated last_name"
  }
  @invalid_attrs %{first_name: nil, last_name: nil, only_reserved: nil, paid: nil, reservation_code: nil}


  describe "index" do
    setup [:setup_auth]
    test "lists all tickets", %{conn: conn} do
      conn = get(conn, Routes.ticket_path(conn, :index))
      assert json_response(conn, 200)["data"] !== []
    end
  end

  describe "create" do
    setup [:setup_auth_no_ticket]
    test "Reserve ticket", %{conn: conn} do
      conn = post(conn, Routes.ticket_path(conn, :create), ticket: @create_attrs)
      assert json_response(conn, 201)["data"] !== []
    end
  end

  describe "update ticket" do
    setup [:setup_auth]

    test "renders ticket when data is valid", %{conn: conn, ticket: %Ticket{id: id} = ticket} do
      conn = put(conn, Routes.ticket_path(conn, :update, ticket), ticket: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.ticket_path(conn, :show, id))

      assert length(Map.keys(json_response(conn, 200)["data"])) != 0
    end

    test "renders errors when data is invalid", %{conn: conn, ticket: ticket} do
      conn = put(conn, Routes.ticket_path(conn, :update, ticket), ticket: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end


  defp setup_auth %{conn: conn} do
    ticket = insert(:ticket)
    user = ticket.user
    {:ok, jwt} = Auth.create_token(user)
    conn = conn
           |> put_req_header("accept", "application/json")
           |> put_req_header("authorization", "Bearer #{jwt}")
    {:ok, conn: conn, user: user, ticket: ticket}
  end

  defp setup_auth_no_ticket %{conn: conn} do
    user = insert(:user)
    {:ok, jwt} = Auth.create_token(user)
    conn = conn
           |> put_req_header("accept", "application/json")
           |> put_req_header("authorization", "Bearer #{jwt}")
    {:ok, conn: conn, user: user}
  end
end
