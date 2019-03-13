defmodule TicketApiWeb.PaymentControllerTest do
  use TicketApiWeb.ConnCase

  alias TicketApi.Pay
  alias TicketApi.Pay.Payment

  @create_attrs %{
    info: "some info"
  }
  @update_attrs %{
    info: "some updated info"
  }
  @invalid_attrs %{info: nil}

  def fixture(:payment) do
    {:ok, payment} = Pay.create_payment(@create_attrs)
    payment
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all payments", %{conn: conn} do
      conn = get(conn, Routes.payment_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create payment" do
    test "renders payment when data is valid", %{conn: conn} do
      conn = post(conn, Routes.payment_path(conn, :create), payment: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.payment_path(conn, :show, id))

      assert %{
               "id" => id,
               "info" => "some info"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.payment_path(conn, :create), payment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_payment(_) do
    payment = fixture(:payment)
    {:ok, payment: payment}
  end
end
