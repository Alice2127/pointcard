defmodule Pointcard.RanksTest do
  use Pointcard.DataCase

  alias Pointcard.Ranks

  describe "ranks" do
    alias Pointcard.Ranks.Rank

    import Pointcard.RanksFixtures

    @invalid_attrs %{name: nil}

    test "list_ranks/0 returns all ranks" do
      rank = rank_fixture()
      assert Ranks.list_ranks() == [rank]
    end

    test "get_rank!/1 returns the rank with given id" do
      rank = rank_fixture()
      assert Ranks.get_rank!(rank.id) == rank
    end

    test "create_rank/1 with valid data creates a rank" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Rank{} = rank} = Ranks.create_rank(valid_attrs)
      assert rank.name == "some name"
    end

    test "create_rank/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ranks.create_rank(@invalid_attrs)
    end

    test "update_rank/2 with valid data updates the rank" do
      rank = rank_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Rank{} = rank} = Ranks.update_rank(rank, update_attrs)
      assert rank.name == "some updated name"
    end

    test "update_rank/2 with invalid data returns error changeset" do
      rank = rank_fixture()
      assert {:error, %Ecto.Changeset{}} = Ranks.update_rank(rank, @invalid_attrs)
      assert rank == Ranks.get_rank!(rank.id)
    end

    test "delete_rank/1 deletes the rank" do
      rank = rank_fixture()
      assert {:ok, %Rank{}} = Ranks.delete_rank(rank)
      assert_raise Ecto.NoResultsError, fn -> Ranks.get_rank!(rank.id) end
    end

    test "change_rank/1 returns a rank changeset" do
      rank = rank_fixture()
      assert %Ecto.Changeset{} = Ranks.change_rank(rank)
    end
  end
end
