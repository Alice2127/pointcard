defmodule Pointcard.Ranks.Rank do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ranks" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(rank, attrs) do
    rank
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
