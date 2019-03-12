defmodule TicketApi.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :only_reserved, :boolean, default: true, null: false
      add :paid, :boolean, default: false, null: false
      add :first_name, :string
      add :last_name, :string
      add :reservation_code, :string
      add :event_id, references(:events, on_delete: :nothing)
      add :ticket_type_id, references(:ticket_types, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:tickets, [:event_id])
    create index(:tickets, [:ticket_type_id])
    create index(:tickets, [:user_id])
  end
end
