defmodule TicketApi.Repo.Migrations.CreateTicketCounts do
  use Ecto.Migration

  def change do
    create table(:ticket_counts) do
      add :max_size, :integer
      add :size_left, :integer
      add :event_id, references(:events, on_delete: :nothing)
      add :ticket_type_id, references(:ticket_types, on_delete: :nothing)

      timestamps()
    end

    create index(:ticket_counts, [:event_id])
    create index(:ticket_counts, [:ticket_type_id])
  end
end
