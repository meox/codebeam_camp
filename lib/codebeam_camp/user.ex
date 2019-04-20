defmodule CodebeamCamp.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:email, :string)
    field(:hash, :string)
    field(:validated, :boolean)

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:email, :hash])
    |> validate_required([:email, :hash])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
