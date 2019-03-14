defmodule TicketApi.Tick.Ticket do
  use Ecto.Schema
  import Ecto.Changeset
  alias TicketApi.Tt
  alias TicketApi.Tc


  schema "tickets" do
    field :first_name, :string
    field :last_name, :string
    field :only_reserved, :boolean, default: false
    field :paid, :boolean, default: false
    field :reservation_code, :string
    field :count, :integer
    belongs_to :ticket_type, TicketApi.Tt.TicketType, foreign_key: :ticket_type_id
    belongs_to :event, TicketApi.Ev.Event, foreign_key: :event_id
    belongs_to :user, TicketApi.Auth.User, foreign_key: :user_id
    has_one :payment, TicketApi.Pay.Payment

    timestamps()
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [:only_reserved, :paid, :first_name, :last_name, :reservation_code, :count, :ticket_type_id, :user_id, :event_id])
    |> generate_reservation_code()
    |> validate_required([:only_reserved, :paid, :first_name, :last_name, :reservation_code, :ticket_type_id, :event_id])
    |> validate_ticket_count
  end

  defp generate_reservation_code(changeset) do
    if is_nil(get_field(changeset, :created_at)) do
      put_change(changeset, :reservation_code, Randomizer.generate!(7))
    else
      changeset
    end
  end

  def validate_ticket_count(changeset) do
    if is_nil(get_field(changeset, :created_at)) do
      ticket_type_id = get_field(changeset, :ticket_type_id)
      count = get_field(changeset, :count)
      event_id = get_field(changeset, :count)
      case Tt.validate_type(ticket_type_id, count, event_id) do
        {:ok, ticket_count} -> reserve_ticket_count(changeset, ticket_count, count)
        {:error, :not_found} -> add_error(changeset, :ticket_type_id, "Association not found")
        {:error, :wrong_count} -> add_error(changeset, :count, "Wrong count for ticket count of this type")
        {:error, :too_many} -> add_error(changeset, :count, "You want to buy too many tickets")
      end
    else
      changeset
    end
  end

  defp reserve_ticket_count(changeset, ticket_count, count) do
    Tc.update_ticket_count(ticket_count, %{size_left: ticket_count.size_left - count})
    changeset
  end
end
