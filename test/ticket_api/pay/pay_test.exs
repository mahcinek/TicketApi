defmodule TicketApi.PayTest do
  use TicketApi.DataCase

  alias TicketApi.Pay

  describe "payments" do
    alias TicketApi.Pay.Payment

    @valid_attrs %{info: "some info"}
    @update_attrs %{info: "some updated info"}
    @invalid_attrs %{info: nil}

    def payment_fixture(attrs \\ %{}) do
      {:ok, payment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pay.create_payment()

      payment
    end

    test "list_payments/0 returns all payments" do
      payment = payment_fixture()
      assert Pay.list_payments() == [payment]
    end

    test "get_payment!/1 returns the payment with given id" do
      payment = payment_fixture()
      assert Pay.get_payment!(payment.id) == payment
    end

    test "create_payment/1 with valid data creates a payment" do
      assert {:ok, %Payment{} = payment} = Pay.create_payment(@valid_attrs)
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
      assert payment == Pay.get_payment!(payment.id)
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
