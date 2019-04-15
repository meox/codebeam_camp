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

    with true <- is_valid_email(email),
         {:ok, hash} <- RegisterDB.register_email(email) do
      Mailer.send(email, hash)
      {:noreply, assign(socket, :registered, true)}
    else
      false ->
        {:noreply, assign(socket, registered: false, btn_status: "Invalid")}

      {:error, :already_registered} ->
        {:noreply, assign(socket, registered: false, btn_status: "Present")}
    end
  end

  def handle_event("validate", %{"email" => ""} = value, socket) do
    Logger.info("validate user: #{inspect(value)}")
    {:noreply, assign(socket, email_valid: true, registered: false)}
  end

  def handle_event("validate", %{"email" => email} = value, socket) do
    Logger.info("validate user: #{inspect(value)}")

    if is_valid_email(email) do
      {:noreply, assign(socket, email_valid: true, registered: false, btn_status: "Subscribe")}
    else
      {:noreply, assign(socket, email_valid: false, registered: false, btn_status: "Invalid")}
    end
  end

  ##### PRIVATE #####

  defp is_valid_email(""), do: false

  defp is_valid_email(email),
    do: Regex.match?(~r(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$), email)
end
