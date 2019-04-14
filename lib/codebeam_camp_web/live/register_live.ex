defmodule CodebeamCamp.RegisterLiveView do
  use Phoenix.LiveView
  require Logger
  alias CodebeamCamp.{Mailer, RegisterDB}

  def render(assigns) do
    ~L"""
      <form phx-change="validate" phx-submit="register">
        <input class="email" name="email" placeholder="me@email.com" />
        <%= if @registered do %>
          <button class="register" type="submit" disabled><%= @btn_status %></button>
        <% else %>
          <%= if @email_valid do %>
            <button class="register" type="submit"><%= @btn_status %></button>
          <% else %>
            <button class="register-invalid" type="submit">Invalid</button>
          <% end %>
        <% end %>
      </form>
    """
  end

  def mount(_session, socket) do
    Logger.info("Mounting CodebeamCamp.RegisterLiveView")
    {:ok, assign(socket, registered: false, btn_status: "Subscribe", email_valid: true)}
  end

  def handle_event("register", %{"email" => email} = value, socket) do
    Logger.info("register user: #{inspect(value)}")
    case RegisterDB.register_email(email) do
      {:ok, hash} ->
        Mailer.send("glmeocci@gmail.com", hash)

        {:noreply, assign(socket, :registered, true)}
      {:error, :already_registered, _} ->
        {:noreply, assign(socket, registered: true, email: "Already Subscribed")}
    end
  end

  def handle_event("validate", %{"email" => ""} = value, socket) do
    Logger.info("validate user: #{inspect(value)}")
    {:noreply, assign(socket, email_valid: true, registered: false)}
  end

  def handle_event("validate", %{"email" => email} = value, socket) do
    Logger.info("validate user: #{inspect(value)}")
    if Regex.match?(~r(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$), email) do
      {:noreply, assign(socket, email_valid: true, registered: false)}
    else
      {:noreply, assign(socket, email_valid: false, registered: false)}
    end
  end
end
