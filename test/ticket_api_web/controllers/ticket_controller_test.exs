defmodule TicketApiWeb.TicketControllerTest do
  use TicketApiWeb.ConnCase

  alias TicketApi.Auth
  alias TicketApi.Repo
  alias TicketApi.Tick.Ticket
  import TicketApi.Factory

  def create_attrs() do

  %{
    first_name: "some first_name",
    last_name: "some last_name",
    count: 2
  }
  end
  @update_attrs %{
    first_name: "some updated first_name",
    last_name: "some updated last_name"
  }
  @invalid_attrs %{first_name: nil, last_name: nil, only_reserved: nil, paid: nil, reservation_code: nil}


  describe "index" do
    setup [:setup_auth]
    test "lists all tickets", %{conn: conn} do
      conn = get(conn, Routes.ticket_path(conn, :index))
      |> doc(description: "List all tickets", operation_id: "list_tickets")
      assert json_response(conn, 200)["data"] !== []
    end
  end

  describe "create" do
    setup [:setup_auth]
    test "Reserve ticket", %{conn: conn, ticket: ticket} do
      attrs = Map.put(create_attrs(), :event_id, ticket.event_id)
                      |> Map.put(:ticket_type_id, ticket.ticket_type_id)
      conn = post(conn, Routes.ticket_path(conn, :create), ticket: attrs)
      |> doc(description: "Reserve ticket", operation_id: "reserve_ticket")
      assert json_response(conn, 201)["data"] !== []
    end
  end

  describe "update ticket" do
    setup [:setup_auth]

    test "renders ticket when data is valid", %{conn: conn, ticket: %Ticket{id: id} = ticket} do

      conn = put(conn, Routes.ticket_path(conn, :update, ticket), ticket: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.ticket_path(conn, :show, id))
      |> doc(description: "Update ticket", operation_id: "update_ticket")

      assert length(Map.keys(json_response(conn, 200)["data"])) != 0
    end

    test "renders errors when data is invalid", %{conn: conn, ticket: ticket} do
      conn = put(conn, Routes.ticket_path(conn, :update, ticket), ticket: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end


  defp setup_auth %{conn: conn} do
    ticket = insert(:ticket)
    ticket = ticket |>Repo.preload([ticket_type: [:ticket_counts]])
    user = ticket.user
    TicketApi.Tc.update_ticket_count(List.first(ticket.ticket_type.ticket_counts), %{event_id: ticket.event_id})
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
