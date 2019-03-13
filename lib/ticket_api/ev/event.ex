defmodule TicketApi.Ev.Event do
  use Ecto.Schema
  import Ecto.Changeset


  schema "events" do
    field :adress, :string
    field :name, :string
    field :start_at, :utc_datetime
    has_many :ticket_counts, TicketApi.Tc.TicketCount
    has_many :tickets, TicketApi.Tick.Ticket

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :adress, :start_at])
    |> validate_required([:name, :adress, :start_at])
  end
end
