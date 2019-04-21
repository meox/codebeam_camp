defmodule CodebeamCamp.RegisterDB do
  use GenServer

  alias CodebeamCamp.{Repo, User}
  import Ecto.Query, only: [from: 2]

  @me __MODULE__

  def start_link(_) do
    GenServer.start_link(@me, %{}, name: @me)
  end

  @impl true
  def init(_) do
    {:ok, %{}}
  end

  def register_email(email) do
    GenServer.call(@me, {:register, email})
  end

  def activate(email, hash) do
    GenServer.call(@me, {:activate, email, hash})
  end

  def list_emails(with_pending \\ false) do
    query =
      if with_pending do
        User
      else
        from(u in User, where: u.validated == true)
      end

    query
    |> Repo.all()
    |> Enum.map(fn %User{} = u ->
      IO.puts("#{u.email}, h:#{u.hash}, validate: #{u.validated}")
    end)
  end

  @impl true
  def handle_call({:register, email}, _from, state) do
    query = from(u in User, where: u.email == ^email, select: u.hash)
    case Repo.one(query) do
      nil ->
        hash = UUID.uuid4()
        case save_into_db(email, hash) do
          {:ok, _record} ->
            {:reply, {:ok, hash}, state}

          {:error, [{:email, _error}]} ->
            {:reply, {:error, :db_error}, state}
        end
      hash ->
        {:reply, {:error, :already_registered, hash}, state}
    end
  end

  @impl true
  def handle_call({:activate, email, hash}, _from, state) do
    query =
      from(u in User,
        where: u.email == ^email and u.hash == ^hash,
        select: u
      )

    case Repo.one(query) do
      nil ->
        {:reply, {:error, :not_present}, state}

      user ->
        user
        |> Ecto.Changeset.change(validated: true)
        |> Repo.update()

        {:reply, {:ok, :validated}, state}
    end
  end

  ##### PRIVATE #####

  defp save_into_db(email, hash) do
    %User{}
    |> User.changeset(%{email: email, hash: hash})
    |> Repo.insert()
  end
end
