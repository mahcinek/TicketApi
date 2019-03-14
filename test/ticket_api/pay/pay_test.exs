defmodule TicketApi.PayTest do
  use TicketApi.DataCase
  import TicketApi.Factory

  alias TicketApi.Pay

  describe "payments" do
    alias TicketApi.Pay.Payment

    @update_attrs %{info: "some updated info"}
    @invalid_attrs %{info: nil}

    def payment_fixture(_attrs \\ %{}) do
      insert(:payment)
    end

    test "list_payments/0 returns all payments" do
      payment = payment_fixture()
      assert List.first(Pay.list_payments()).id == payment.id
    end

    test "get_payment!/1 returns the payment with given id" do
      payment = payment_fixture()
      assert Pay.get_payment!(payment.id).id == payment.id
    end

    test "create_payment/1 with valid data creates a payment" do
      payment = payment_fixture(:payment)
      assert payment.info == "some info"
    end

    test "create_payment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pay.create_payment(@invalid_attrs)
    end

    test "update_payment/2 with valid data updates the payment" do
      payment = payment_fixture()
      assert {:ok, %Payment{} = payment} = Pay.update_payment(payment, @update_attrs)
      assert payment.info == "some updated info"
    end

    test "update_payment/2 with invalid data returns error changeset" do
      payment = payment_fixture()
      assert {:error, %Ecto.Changeset{}} = Pay.update_payment(payment, @invalid_attrs)
      assert payment.id == Pay.get_payment!(payment.id).id
    end

    test "delete_payment/1 deletes the payment" do
      payment = payment_fixture()
      assert {:ok, %Payment{}} = Pay.delete_payment(payment)
      assert_raise Ecto.NoResultsError, fn -> Pay.get_payment!(payment.id) end
    end

    test "change_payment/1 returns a payment changeset" do
      payment = payment_fixture()
      assert %Ecto.Changeset{} = Pay.change_payment(payment)
    end
  end
end
