defmodule PointcardWeb.UserLive.Index do
  use PointcardWeb, :live_view

  alias Pointcard.Users
  alias Pointcard.Users.User

  @impl true
  def mount(params, _session, socket) do
    IO.inspect("---mount---")

    {:ok,
     socket
     |> assign(:name, "")
     |> assign(:page_size, 10)
     |> assign(:users, list_users(params))}
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
  def handle_event("delete", params = %{"id" => id}, socket) do
    IO.inspect("---delete---")
    user = Users.get_user!(id)
    {:ok, _} = Users.delete_user(user)

    {:noreply, assign(socket, :users, list_users(params))}
  end

  @impl true
  def handle_event("update_page_size", params, socket) do
    page_size =
      params
      |> Map.get("page_size")

    params =
      params
      |> Map.put("name", socket.assigns.name)

    socket =
      socket
      |> assign(:page_size, String.to_integer(page_size))
      |> assign(:users, list_users(params))

    {:noreply, socket}
  end

  @impl true
  def handle_event("update_page", params, socket) do
    page =
      params
      |> Map.get("page")

    params =
      params
      |> Map.put("name", socket.assigns.name)
      |> Map.put("page_size", socket.assigns.page_size)

    socket =
      socket
      |> assign(:page, String.to_integer(page))
      |> assign(:users, list_users(params))

    {:noreply, socket}
  end

  def handle_event("search", params, socket) do
    name = params["name"]

    {:noreply,
     socket
     |> assign(:name, name)
     |> assign(:users, list_users(params))}
  end

  defp list_users(params) do
    params2 = Map.merge(default_params(), params) |> IO.inspect()
    Users.list_users(params2)
  end

  defp default_params() do
    %{"name" => "", "page" => "1", "page_size" => "10"}
  end
end
