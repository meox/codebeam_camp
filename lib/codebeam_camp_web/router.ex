defmodule CodebeamCampWeb.Router do
  use CodebeamCampWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CodebeamCampWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/active_sub", PageController, :active_subscription_email
  end

  # Other scopes may use custom stacks.
  scope "/api", CodebeamCampWeb do
    pipe_through :api

    get "/active_sub", PageController, :active_subscription
  end
end
