defmodule TicketApi.Repo.Migrations.AddPriceToTicketType do
  use Ecto.Migration

  def change do
    alter table(:ticket_types) do
      add :price, :integer
    end
  end
end
