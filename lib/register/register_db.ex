defmodule CodebeamCamp.RegisterDB do
  use Agent

  alias CodebeamCamp.Email

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

  def activate(email, hash) do
    case Agent.get(@me, fn state -> Map.get(state, email) end) do
      nil ->
        {:error, "email not present"}
      %Email{hash: ^hash} = record ->
        do_activate(email, record)
        {:ok, :validated}
      _ ->
        {:error, "bad arguments"}
    end
  end

  def list_emails do
    @me
    |> Agent.get(&(&1))
    |> Enum.each(fn {k, v} ->
      IO.puts("#{k}, #{v.hash}, #{v.validated}")
    end)
  end

  ##### PRIVATE #####

  defp do_register(email, state) do
    hash = UUID.uuid4()
    record = %Email{hash: hash}
    {{:ok, hash}, Map.put(state, email, record)}
  end

  defp do_activate(email, record) do
    Agent.update(
      @me,
      fn state ->
        Map.put(state, email, %{record | validated: true})
    end)
  end
end
