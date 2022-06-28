defmodule PointcardWeb.Paginator do
  @moduledoc """
  Paginator.
  """

  use Phoenix.Component

  def render(assigns) do
    ~H"""
    <div>
      <div>
       <p>表示件数:</p>
        <div>
          <form phx-change="update_page_size">
            <select name="page_size">
            <option value="10" selected={@page_size == 10}>10</option>
            <option value="30" selected={@page_size == 30}>30</option>
            <option value="100" selected={@page_size == 100}>100</option>
            </select>
          </form>
        </div>
       <p><%= @total_entries %>件中 <%= @page_size * (@page - 1) + 1 %>~<%= @page_size * @page %>件を表示</p>
      </div>
      <div>
      <button phx-click="update_page" phx-value-page="1" disabled={@page == 1}>先頭へ</button>
      <button phx-click="update_page" phx-value-page={@page - 1} disabled={@page == 1}>前へ</button>
      <button phx-click="update_page" phx-value-page={@page + 1} disabled={@page == @total_pages}>次へ</button>
      <button phx-click="update_page" phx-value-page={@total_pages} disabled={@page == @total_pages}>最後尾へ</button>
      </div>
    </div>
    """
  end
end
