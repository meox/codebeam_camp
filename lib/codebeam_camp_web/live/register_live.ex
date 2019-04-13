defmodule CodeBeam.RegisterLiveView do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
      <form>
        <input class="email" placeholder="me@email.com" />
        <button class="register" type="submit">Subscribe</button>
      </form>
    """
  end
end
