defmodule PointcardWeb.RankLive.Show do
  use PointcardWeb, :live_view

  alias Pointcard.Ranks

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:rank, Ranks.get_rank!(id))}
  end

  defp page_title(:show), do: "Show Rank"
  defp page_title(:edit), do: "Edit Rank"
end
