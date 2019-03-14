defmodule TicketApiWeb.PaymentController do
  use TicketApiWeb, :controller

  alias TicketApi.Pay
  alias TicketApi.Pay.Payment

  action_fallback TicketApiWeb.FallbackController

  def index(conn, _params) do
    payments = Pay.list_payments(Guardian.Plug.current_resource(conn))
    render(conn, "index.json", payments: payments)
  end

  def create(conn, %{"payment" => payment_params}) do
    Map.put(payment_params, "user_id", Guardian.Plug.current_resource(conn).id)
    with {:ok, %Payment{} = payment} <- Pay.create_payment(payment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.payment_path(conn, :show, payment))
      |> render("show.json", payment: payment)
    end
  end

  def show(conn, %{"id" => id}) do
    user_id = Guardian.Plug.current_resource(conn).id
    payment = Pay.get_payment!(id, user_id)
    render(conn, "show.json", payment: payment)
  end
end
