defmodule TicketApi.Tt.TicketType do
  use Ecto.Schema
  import Ecto.Changeset


  schema "ticket_types" do
    field :name, :string
    field :t_type, :string
    field :price, :integer
    has_many :tickets, TicketApi.Tick.Ticket
    has_many :ticket_counts, TicketApi.Tc.TicketCount

    timestamps()
  end

  @doc false
  def changeset(ticket_type, attrs) do
    ticket_type
    |> cast(attrs, [:name, :t_type, :price])
    |> validate_required([:name, :t_type, :price])
    |> validate_inclusion(:t_type, ["multiple", "altogether", "avoid_one"])
  end
end
