defmodule TicketApi.Repo.Migrations.ChangeReservationDefault do
  use Ecto.Migration

  def change do
    alter table(:tickets) do
      modify :only_reserved, :boolean, default: true
    end
  end
end
