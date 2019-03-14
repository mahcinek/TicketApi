defmodule TicketApiWeb.PaymentControllerTest do
  use TicketApiWeb.ConnCase
  import TicketApi.Factory

  alias TicketApi.Auth

  def valid_attrs do
    %{info: "some info",
      card_info: "info",
      currency: "eur"}
  end

  @invalid_attrs %{info: nil}


  describe "index" do
    setup [:setup_auth]
    test "lists all payments", %{conn: conn} do
      conn = get(conn, Routes.payment_path(conn, :index))
      assert json_response(conn, 200)["data"] !== []
    end
  end

  describe "create payment" do
    setup [:setup_auth]
    test "renders payment when data is valid", %{conn: conn, payment: payment} do
      attrs =  Map.put(valid_attrs(), :user_id, payment.user_id) |> Map.put(:ticket_id, payment.ticket_id)
      conn = post(conn, Routes.payment_path(conn, :create), payment: attrs)
      |> doc(description: "Create payment", operation_id: "create_payment")
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.payment_path(conn, :show, id))
            |> doc(description: "Show payments", operation_id: "show_payments")

      assert %{
               "id" => id,
               "info" => "some info"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.payment_path(conn, :create), payment: @invalid_attrs)
              |> doc(description: "invalid creattion params", operation_id: "create_invalid")
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp setup_auth %{conn: conn} do
    payment = insert(:payment)
    user = payment.user
    {:ok, jwt} = Auth.create_token(user)
    conn = conn
           |> put_req_header("accept", "application/json")
           |> put_req_header("authorization", "Bearer #{jwt}")
    {:ok, conn: conn, user: user, payment: payment}
  end

  defp setup_auth_no_payment %{conn: conn} do
    user = insert(:user)
    {:ok, jwt} = Auth.create_token(user)
    conn = conn
           |> put_req_header("accept", "application/json")
           |> put_req_header("authorization", "Bearer #{jwt}")
    {:ok, conn: conn, user: user}
  end
end
