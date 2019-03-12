defmodule TicketApi.Repo.Migrations.CreateTicketTypes do
  use Ecto.Migration

  def change do
    create table(:ticket_types) do
      add :name, :string
      add :t_type, :string

      timestamps()
    end

  end
end
