defmodule CodebeamCamp.RegisterDB do
  use Agent

  @me __MODULE__

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: @me)
  end

  def register_email(email) do
    Agent.get_and_update(@me, fn state ->
      case Map.get(state, email) do
        nil ->
          do_register(email, state)
        val ->
          {{:error, :already_registered, val}, state}
      end
    end)
  end

  ##### PRIVATE #####

  defp do_register(email, state) do
    hash = "aaaa"
    {{:ok, hash}, Map.put(state, email, hash)}
  end

end
