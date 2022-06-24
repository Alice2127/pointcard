defmodule Pointcard.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Pointcard.Ranks.Rank

  schema "users" do
    field :name, :string
    belongs_to(:rank, Rank)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :rank_id])
    |> validate_required([:name, :rank_id])
  end
end
