defmodule CodeBeam.RegisterLiveView do
  use Phoenix.LiveView
  require Logger

  def render(assigns) do
    ~L"""
      <form phx-change="validate" phx-submit="register">
        <input class="email" name="email" placeholder="me@email.com" />
        <%= if @registered do %>
        <button class="register" type="submit" disabled>Registered</button>
        <%= else %>
        <button class="register" type="submit">Subscribe</button>
        <%= end %>
      </form>
    """
  end

  def mount(_session, socket) do
    Logger.info("Mounting CodeBeam.RegisterLiveView")
    {:ok, assign(socket, registered: false)}
  end

  def handle_event("register", value, socket) do
    Logger.info("register user: #{inspect(value)}")
    {:noreply, assign(socket, :registered, true)}
  end

  def handle_event("validate", value, socket) do
    Logger.info("validate user: #{inspect(value)}")
    {:noreply, assign(socket, :registered, false)}
  end
end
