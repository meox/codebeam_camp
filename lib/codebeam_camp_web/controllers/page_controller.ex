defmodule CodebeamCampWeb.PageController do
  use CodebeamCampWeb, :controller

  alias CodebeamCamp.RegisterDB

  def index(conn, _params) do
    render(conn, "index.html", events: events())
  end

  def active_subscription_email(conn, %{"email" => email, "hash" => hash}) do
    case RegisterDB.activate(email, hash) do
      {:ok, :validated} ->
        html(conn, "Subscription activated for <strong>#{email}</strong>")

      {:error, reason} ->
        html(
          conn,
          "Error activating subscription for <strong>#{email}</strong><br><br>Error: #{reason}"
        )
    end
  end

  def active_subscription(conn, %{"email" => email, "hash" => hash}) do
    case RegisterDB.activate(email, hash) do
      {:ok, :validated} -> json(conn, %{"ok" => true})
      {:error, reason} -> json(conn, %{"ok" => false, "reason" => reason})
    end
  end

  def events do
    [
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
      },
      %{
        name: "GigCityElixir",
        date: "18-19 October 2019",
        location: "Chattanooga, Tn",
        url: "https://www.gigcityelixir.com/"
      }
    ]
  end
end
