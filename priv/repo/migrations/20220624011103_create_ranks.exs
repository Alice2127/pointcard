defmodule Pointcard.Repo.Migrations.CreateRanks do
  use Ecto.Migration

  def change do
    create table(:ranks) do
      add :name, :string

      timestamps()
    end
  end
end
