defmodule CodebeamCampWeb.PageController do
  use CodebeamCampWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", events: events())
  end

  def events do
    [
      %{
        name: "Code BEAM STO",
        date: "16-17 May 2019",
        location: "Stockholm",
        url: "https://codesync.global/conferences/code-beam-sto-2019/"
      },
      %{
        name: "Code Elixir LDN",
        date: "18 July 2019",
        location: "London",
        url: "https://codesync.global/conferences/code-elixir-ldn-2019/"
      },
      %{
        name: "ElixirConf US",
        date: "29-30 August 2019",
        location: "Aurora, CO",
        url: "https://elixirconf.com/2019/"
      }
    ]
  end
end
