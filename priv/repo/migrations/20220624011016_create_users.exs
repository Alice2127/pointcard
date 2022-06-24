defmodule Pointcard.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :rank_id, :integer

      timestamps()
    end
  end
end
