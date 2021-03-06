defmodule TicketApi.Pay.Payment do
  use Ecto.Schema
  import Ecto.Changeset
  alias TicketApi.Pay.PaymentAdapter
  alias TicketApi.Tick
  alias TicketApi.Repo


  schema "payments" do
    field :info, :string
    field :card_info, :string, virtual: true
    field :currency, :string, virtual: true
    belongs_to :ticket, TicketApi.Tick.Ticket, foreign_key: :ticket_id
    belongs_to :user, TicketApi.Auth.User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [:info, :currency, :card_info, :ticket_id, :user_id])
    |> validate_required([:info, :ticket_id, :user_id])
    |> validate_has_card_info_on_create
    |> validate_inclusion(:currency, [nil, "eur", "pln", "usd"])
    |> charge_money
    |> nullify_card_info
  end

  # if valid changeset on create check if card info exists, it isn't stored since its a security vulnerability
  def validate_has_card_info_on_create(changeset) do
    if changeset.valid? do
      if is_nil(get_field(changeset, :created_at)) do
        check_nil_card_info_currency(changeset)
      else
        changeset
      end
    else
      changeset
    end
  end

  # charge money with provided adapter only on create if valid
  def charge_money(changeset) do
    if changeset.valid? and is_nil(get_field(changeset, :created_at)) do
      ticket = Tick.get_ticket!(get_field(changeset, :ticket_id))
              |> Repo.preload(:ticket_type)
      case PaymentAdapter.charge(
            ticket.count * ticket.ticket_type.price, nil, String.to_atom(get_field(changeset, :currency))
            ) do
        {:ok,  _} ->
          save_ticket(ticket, changeset)
        {:error, :card_error} ->
          add_error(changeset, :card_info, "Card error")
        {:error, :payment_error} ->
          add_error(changeset, :card_info, "Payment error")
        {:error, :currency_not_supported} ->
          add_error(changeset, :currency, "Currency not suported")
      end
    end
    changeset
  end

  # card info after charge is nullyfied since its a security vulnerability
  def nullify_card_info(changeset) do
    change(changeset, %{card_info: nil})
  end

  # After ticket is payed for its no longer a reservation
  defp save_ticket(ticket, changeset) do
    Tick.update_ticket(ticket, %{reservation_only: false})
    changeset
  end

  # check on create if currency and card info aren't blank, they will be later wiped
  defp check_nil_card_info_currency(changeset)do
    if is_nil(get_field(changeset, :card_info)) do
      add_error(changeset, :card_info, "Can't be blank")
    end
    if is_nil(get_field(changeset, :currency)) do
      add_error(changeset, :currency, "Can't be blank")
    end
    changeset
  end
end
