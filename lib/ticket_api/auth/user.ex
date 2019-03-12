defmodule TicketApi.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :first_name, :string
    field :is_active, :boolean, default: false
    field :last_name, :string
    field :phone_number, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :is_active, :first_name, :last_name, :phone_number])
    |> validate_required([:email, :is_active, :first_name, :last_name, :phone_number])
    |> unique_constraint(:email)
  end
end
