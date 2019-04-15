defmodule CodebeamCamp.RegisterDB do
  use GenServer

  alias CodebeamCamp.Email

  @me __MODULE__

  def start_link(_) do
    GenServer.start_link(@me, %{}, name: @me)
  end

  @impl true
  def init(_) do
    :email_table =
      PersistentEts.new(:email_table, "/tmp/codebeam_camp_email_table.tab", [:named_table])

    {:ok, %{}}
  end

  def register_email(email) do
    case :ets.lookup(:email_table, email) do
      [] ->
        do_register(email)

      [_record] ->
        {:error, :already_registered}
    end
  end

  def activate(email, hash) do
    case :ets.lookup(:email_table, email) do
      [] ->
        {:error, "email not present"}

      [{^email, %Email{hash: ^hash} = record}] ->
        do_activate(email, record)
        {:ok, :validated}

      _ ->
        {:error, "bad arguments"}
    end
  end

  def list_emails do
    :ets.foldr(
      fn {k, v}, acc ->
        [{k, v.hash, v.validated} | acc]
      end,
      [],
      :email_table
    )
  end

  @impl true
  def handle_call({:register, email}, _from, state) do
    hash = UUID.uuid4()
    record = %Email{hash: hash}
    :ets.insert(:email_table, {email, record})
    {:reply, {:ok, hash}, state}
  end

  @impl true
  def handle_call({:activate, email, record}, _from, state) do
    updated_record = %{record | validated: true}
    :ets.insert(:email_table, {email, updated_record})
    {:reply, :ok, Map.put(state, email, record)}
  end

  ##### PRIVATE #####

  defp do_register(email) do
    GenServer.call(@me, {:register, email})
  end

  defp do_activate(email, record) do
    GenServer.call(@me, {:activate, email, record})
  end
end
