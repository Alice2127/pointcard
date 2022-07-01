defmodule Pointcard.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Pointcard.Repo

  alias Pointcard.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """

  def list_users(params) do
    {[page: page, page_size: page_size], search_conditions} =
      params
      |> Map.to_list()
      |> Enum.map(fn {key, value} -> {String.to_atom(key), value} end)
      |> Keyword.split([:page, :page_size])

    users =
      search_conditions
      |> build_list_users_query(users_base_query())
      |> Repo.paginate(page: page, page_size: page_size)

    entries =
      users.entries
      |> Repo.preload(:rank)

    users
    |> Map.put(:entries, entries)
  end

  defp users_base_query() do
    from(user in User,
      join: rank in assoc(user, :rank),
      order_by: [desc: user.inserted_at]
    )
  end

  defp build_list_users_query([], query), do: query

  defp build_list_users_query([condition | rest], query) do
    query = list_users_where(query, condition)
    build_list_users_query(rest, query)
  end

  defp list_users_where(query, {_, nil}), do: query
  defp list_users_where(query, {_, ""}), do: query

  defp list_users_where(query, {:name, name}),
    do:
      from([user, rank] in query,
        where: like(rank.name, ^"%#{name}%") or like(user.name, ^"%#{name}%")
      )

  defp list_users_where(query, _x), do: query

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
