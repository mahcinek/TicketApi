defmodule TicketApi.Tick.Ticket do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tickets" do
    field :first_name, :string
    field :last_name, :string
    field :only_reserved, :boolean, default: false
    field :paid, :boolean, default: false
    field :reservation_code, :string
    field :event_id, :id
    field :ticket_type_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [:only_reserved, :paid, :first_name, :last_name, :reservation_code])
    |> validate_required([:only_reserved, :paid, :first_name, :last_name, :reservation_code])
  end
end
