defmodule TicketApi.Pay.Payment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "payments" do
    field :info, :string
    belongs_to :ticket, TicketApi.Tick.Ticket, foreign_key: :ticket_id
    belongs_to :user, TicketApi.Auth.User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [:info])
    |> validate_required([:info])
  end
end
