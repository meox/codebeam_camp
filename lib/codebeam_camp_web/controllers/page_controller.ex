defmodule CodebeamCampWeb.PageController do
  use CodebeamCampWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
