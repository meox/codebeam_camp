defmodule CodebeamCamp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :hash, :float
      add :validated, :bool

      timestamps()
    end
  end
end
