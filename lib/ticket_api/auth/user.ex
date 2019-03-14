defmodule TicketApi.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    field :first_name, :string
    field :is_active, :boolean, default: false
    field :last_name, :string
    field :phone_number, :string
    has_many :tickets, TicketApi.Tick.Ticket
    has_many :payments, TicketApi.Pay.Payment

    timestamps()
  end

  @doc false

  # validate things like email format, email uniq, password == password_confirmation
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :is_active, :first_name, :last_name, :phone_number, :password, :password_confirmation])
    |> validate_required([:email, :is_active, :first_name, :last_name, :password, :password_confirmation])
    |> validate_format(:email, ~r/@/)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  # Set password hash using Bcrypt from given password
  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, %{password_hash: Bcrypt.hash_pwd_salt(password), password: nil, password_confirmation: nil})
  end

  defp put_password_hash(changeset) do
    changeset
  end
end
