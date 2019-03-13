defmodule TicketApiWeb.PaymentController do
  use TicketApiWeb, :controller

  alias TicketApi.Pay
  alias TicketApi.Pay.Payment

  action_fallback TicketApiWeb.FallbackController

  def index(conn, _params) do
    payments = Pay.list_payments()
    render(conn, "index.json", payments: payments)
  end

  def create(conn, %{"payment" => payment_params}) do
    with {:ok, %Payment{} = payment} <- Pay.create_payment(payment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.payment_path(conn, :show, payment))
      |> render("show.json", payment: payment)
    end
  end

  def show(conn, %{"id" => id}) do
    payment = Pay.get_payment!(id)
    render(conn, "show.json", payment: payment)
  end
end
