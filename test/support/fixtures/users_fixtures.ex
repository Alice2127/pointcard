defmodule Pointcard.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pointcard.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "some name",
        rank_id: 42
      })
      |> Pointcard.Users.create_user()

    user
  end
end
