defmodule TicketApi.Ev.Event do
  use Ecto.Schema
  import Ecto.Changeset


  schema "events" do
    field :adress, :string
    field :name, :string
    field :start_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :adress, :start_at])
    |> validate_required([:name, :adress, :start_at])
  end
end
