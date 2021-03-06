defmodule TicketApi.AuthTest do
  use TicketApi.DataCase

  alias TicketApi.Auth

  describe "users" do
    alias TicketApi.Auth.User

    @valid_attrs %{email: "some@email.pl", password: "otohaslo123", password_confirmation: "otohaslo123", first_name: "some first_name", is_active: true, last_name: "some last_name", phone_number: "some phone_number"}
    @update_attrs %{email: "someupdated@email.pl", password: "updateotohaslo123", password_confirmation: "updateotohaslo123", first_name: "some updated first_name", is_active: false, last_name: "some updated last_name", phone_number: "some updated phone_number"}
    @invalid_attrs %{email: nil, password: nil, password_confirmation: nil, first_name: nil, is_active: nil, last_name: nil, phone_number: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Auth.list_users() == [%User{user | password: nil, password_confirmation: nil}]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Auth.get_user!(user.id) == %User{user | password: nil, password_confirmation: nil }
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Auth.create_user(@valid_attrs)
      assert user.email == "some@email.pl"
      assert user.first_name == "some first_name"
      assert user.is_active == true
      assert user.last_name == "some last_name"
      assert user.phone_number == "some phone_number"
      assert Bcrypt.verify_pass("otohaslo123", user.password_hash)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Auth.update_user(user, @update_attrs)
      assert user.email == "someupdated@email.pl"
      assert user.first_name == "some updated first_name"
      assert user.is_active == false
      assert user.last_name == "some updated last_name"
      assert user.phone_number == "some updated phone_number"
      assert Bcrypt.verify_pass("updateotohaslo123", user.password_hash)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_user(user, @invalid_attrs)
      assert %User{user | password: nil, password_confirmation: nil} == Auth.get_user!(user.id)
      assert Bcrypt.verify_pass("otohaslo123", user.password_hash)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Auth.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Auth.change_user(user)
    end
  end
end
