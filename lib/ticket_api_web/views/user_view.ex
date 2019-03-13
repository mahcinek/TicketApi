defmodule TicketApiWeb.UserView do
  use TicketApiWeb, :view
  alias TicketApiWeb.UserView
  alias TicketApiWeb.ChangesetView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("create.json", %{user: user, token: token}) do
    %{id: user.id,
      email: user.email,
      is_active: user.is_active,
      first_name: user.first_name,
      last_name: user.last_name,
      phone_number: user.phone_number,
      token: token}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      is_active: user.is_active,
      first_name: user.first_name,
      last_name: user.last_name,
      phone_number: user.phone_number}
  end

  def render("error.json", changeset) do
    ChangesetView.render("error.json", changeset)
  end

end
