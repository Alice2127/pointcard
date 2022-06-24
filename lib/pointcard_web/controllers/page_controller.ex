defmodule PointcardWeb.PageController do
  use PointcardWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
