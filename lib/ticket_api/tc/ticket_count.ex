defmodule TicketApi.Tc.TicketCount do
  use Ecto.Schema
  import Ecto.Changeset


  schema "ticket_counts" do
    field :max_size, :integer
    field :size_left, :integer
    field :event_id, :id
    field :ticket_type_id, :id

    timestamps()
  end

  @doc false
  def changeset(ticket_count, attrs) do
    ticket_count
    |> cast(attrs, [:max_size, :size_left])
    |> validate_required([:max_size, :size_left])
  end
end
