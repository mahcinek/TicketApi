defmodule TicketApiWeb.UserControllerTest do
  use TicketApiWeb.ConnCase

  alias TicketApi.Auth
  alias TicketApi.Auth.User

  @create_attrs %{
    email: "some@email.pl",
    first_name: "some first_name",
    is_active: true,
    last_name: "some last_name",
    password: "some password",
    password_confirmation: "some password",
    phone_number: "some phone_number"
  }
  @update_attrs %{
    email: "someupdated@email.pl",
    first_name: "some updated first_name",
    is_active: false,
    last_name: "some updated last_name",
    password: "some updated password",
    password_confirmation: "some updated password",
    phone_number: "some updated phone_number"
  }
  @invalid_attrs %{email: nil, first_name: nil, is_active: nil, last_name: nil, password: nil, password_confirmation: nil, phone_number: nil}

  def fixture(:user) do
    {:ok, user} = Auth.create_user(@create_attrs)
    user
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
            assert length(Map.keys(json_response(conn, 201))) != 0
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do

  setup [:setup_auth]

    test "renders author when data is valid", %{conn: conn, user: %User{id: id} = _user} do
      conn = put(conn, Routes.user_path(conn, :update), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))
      assert %{
                "email" => "someupdated@email.pl",
                "first_name" => "some updated first_name",
                "id" => id,
                "is_active" => false,
                "last_name" => "some updated last_name",
                "phone_number" => "some updated phone_number"
              } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: _user} do
      conn = put(conn, Routes.user_path(conn, :update), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end

  defp setup_auth %{conn: conn} do
    user = fixture(:user)
    {:ok, jwt} = Auth.create_token(user)
    conn = conn
           |> put_req_header("accept", "application/json")
           |> put_req_header("authorization", "Bearer #{jwt}")
    {:ok, conn: conn, user: user, token: jwt}
  end
end
