defmodule TicketApi.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: TicketApi.Repo

  def user_factory do
    %TicketApi.Auth.User{
      last_name: "some last_name",
      first_name: "some first_name",
      email: "email@email.com",
      password: "password",
      password_confirmation: "password",
      is_active: true,
      phone_number: "123412347"
    }
  end

end
