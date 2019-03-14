defmodule TicketApi.Tick.Ticket do
  use Ecto.Schema
  import Ecto.Changeset
  alias TicketApi.Tt
  alias TicketApi.Tc

  schema "tickets" do
    field :first_name, :string
    field :last_name, :string
    field :only_reserved, :boolean, default: true
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
    |> validate_required([:only_reserved, :paid, :first_name, :last_name, :reservation_code, :ticket_type_id, :event_id, :count])
    |> validate_ticket_count
  end

  defp generate_reservation_code(changeset) do
    if is_nil(get_field(changeset, :created_at)) do
      put_change(changeset, :reservation_code, Randomizer.generate!(7))
    else
      changeset
    end
  end

  # ticket count validation for reservations
  def validate_ticket_count(changeset) do
    if changeset.valid? and is_nil(get_field(changeset, :created_at)) do
      ticket_type_id = get_field(changeset, :ticket_type_id)
      count = get_field(changeset, :count)
      event_id = get_field(changeset, :event_id)
      case Tt.validate_type(ticket_type_id, count, event_id) do
        {:ok, ticket_count} -> reserve_ticket_count(changeset, ticket_count, count)
        {:error, :not_found_count} -> add_error(changeset, :ticket_type_id, "Association not found count")
        {:error, :not_found_type} -> add_error(changeset, :ticket_type_id, "Association not found type")
        {:error, :wrong_count} -> add_error(changeset, :count, "Wrong count for ticket count of this type")
        {:error, :too_many} -> add_error(changeset, :count, "You want to buy too many tickets")
      end
    else
      changeset
    end
  end

  # reserve ticket and enqueue job to delete reservation in 15 minutes
  defp reserve_ticket_count(changeset, ticket_count, count) do
    Tc.update_ticket_count(ticket_count, %{size_left: ticket_count.size_left - count})
    {:ok, _ack} = enqueue_feed([get_field(changeset, :reservation_code), ticket_count.id, count])
    changeset
  end

  def in_15_minutes() do
    DateTime.utc_now |> DateTime.add(900, :second)
  end

  def enqueue_feed(args) do
    if Mix.env == :test do
    #   :timer.sleep(1000)
    #   apply(TicketApi.TicketWorker, :perform, args)
    {:ok, nil}
    else
      Exq.enqueue(Exq, "default", 60, TicketApi.TicketWorker, args)
    end
  end
end
