defmodule TicketApi.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :info, :text
      add :user_id, references(:users, on_delete: :nothing)
      add :ticket_id, references(:tickets, on_delete: :nothing)

      timestamps()
    end

    create index(:payments, [:user_id])
    create index(:payments, [:ticket_id])
  end
end
