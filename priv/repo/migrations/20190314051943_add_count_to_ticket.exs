defmodule TicketApi.Repo.Migrations.AddCountToTicket do
  use Ecto.Migration

  def change do
    alter table(:tickets) do
      add :count, :integer, default: 1
    end
  end
end
