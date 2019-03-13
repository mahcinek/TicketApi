defmodule TicketApi.Tc.TicketCount do
  use Ecto.Schema
  import Ecto.Changeset


  schema "ticket_counts" do
    field :max_size, :integer
    field :size_left, :integer
    # field :event_id, :id
    # field :ticket_type_id, :id
    belongs_to :ticket_type, TicketApi.Tt.TicketType, foreign_key: :ticket_type_id
    belongs_to :event, TicketApi.Ev.Event, foreign_key: :event_id

    timestamps()
  end

  @doc false
  def changeset(ticket_count, attrs) do
    ticket_count
    |> cast(attrs, [:max_size, :size_left])
    |> validate_required([:max_size, :size_left])
  end
end
