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

  def ticket_factory do
    %TicketApi.Tick.Ticket{
      first_name: "some updated first_name",
      last_name: "some updated last_name",
      event: build(:event),
      user: build(:user)
    }
  end

  def event_factory do
    %TicketApi.Ev.Event{
      name: "event",
      start_at: ~N[2010-04-17 14:00:00],
      adress: "adress"
    }
  end

end
