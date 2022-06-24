defmodule PointcardWeb.UserLive.Index do
  use PointcardWeb, :live_view

  alias Pointcard.Users
  alias Pointcard.Users.User

  @impl true
  def mount(_params, _session, socket) do
  IO.inspect("---mount---")
    {:ok,
    socket
    |> assign(:userrank, "")
    |> assign(:users, list_users(""))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    IO.inspect("---handle_params---")
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    IO.inspect("---edit---")
    socket
    |> assign(:page_title, "Edit User")
    |> assign(:user, Users.get_user!(id))
  end

  defp apply_action(socket, :new, _params) do
    IO.inspect("---new---")
    socket
    |> assign(:page_title, "New User")
    |> assign(:user, %User{})
  end

  defp apply_action(socket, :index, _params) do
    IO.inspect("---index---")
    socket
    |> assign(:page_title, "Listing Users")
    |> assign(:user, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    IO.inspect("---delete---")
    user = Users.get_user!(id)
    {:ok, _} = Users.delete_user(user)

    {:noreply, assign(socket, :users, list_users(""))}
  end

  def handle_event("search", params, socket) do
    name = params["name"] #覗きたい...
    Debug.debugtool(params, "params")#覗いた。%{"name" => "ノーマル"}ってなってる。

    {:noreply,
    socket
    |> IO.inspect()
    |> assign(:userrank, name)
    |> assign(:users, list_users(name))}
    |> IO.inspect()
  end


  defp list_users(name) do
    Users.list_users(name)
  end
end
