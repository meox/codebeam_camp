defmodule CodebeamCamp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :hash, :string
      add :validated, :boolean, default: false

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
