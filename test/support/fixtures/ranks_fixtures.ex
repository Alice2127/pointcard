defmodule Pointcard.RanksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pointcard.Ranks` context.
  """

  @doc """
  Generate a rank.
  """
  def rank_fixture(attrs \\ %{}) do
    {:ok, rank} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Pointcard.Ranks.create_rank()

    rank
  end
end
