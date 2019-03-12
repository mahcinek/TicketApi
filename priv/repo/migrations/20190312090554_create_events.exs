defmodule TicketApi.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :adress, :text
      add :start_at, :utc_datetime

      timestamps()
    end

  end
end
