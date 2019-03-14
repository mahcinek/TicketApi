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

  def user2_factory do
    %TicketApi.Auth.User{
      last_name: "some last_name",
      first_name: "some first_name",
      email: "emailowo@email.com",
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
      event: insert(:event),
      user: insert(:user),
      ticket_type: insert(:ticket_type3)
    }
  end

  def event_factory do
    %TicketApi.Ev.Event{
      name: "event",
      start_at: ~N[2010-04-17 14:00:00],
      adress: "adress",
      ticket_counts: [build(:ticket_count), build(:ticket_count2)]
    }
  end

  def ticket_type_factory do
    %TicketApi.Tt.TicketType{
      name: "event",
      t_type: "multiple",
      price: 20
    }
  end

  def ticket_count2_factory do
    %TicketApi.Tc.TicketCount{
      max_size: 10,
      size_left: 9,
      ticket_type: build(:ticket_type2)
    }
  end
  def ticket_type2_factory do
    %TicketApi.Tt.TicketType{
      name: "event",
      t_type: "avoid_one",
      price: 35
    }
  end
  def ticket_type3_factory do
    %TicketApi.Tt.TicketType{
      name: "event",
      t_type: "avoid_one",
      ticket_counts: [insert(:ticket_count3)],
      price: 30
    }
  end

  def ticket_count_factory do
    %TicketApi.Tc.TicketCount{
      max_size: 20,
      size_left: 15,
      ticket_type: build(:ticket_type)
    }
  end

  def ticket_count3_factory do
    %TicketApi.Tc.TicketCount{
      max_size: 20,
      size_left: 15
    }
  end

  def payment_factory do
    %TicketApi.Pay.Payment{
      info: "aaa",
      currency: "eur",
      card_info: "info",
      user: build(:user2),
      ticket: build(:ticket)
    }
  end

end
