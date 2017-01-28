defmodule GreenHR.Repo.Migrations.CreateGroup do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string
      
      add :organization_id, references(:organizations)

      timestamps()
    end

    create index(:groups, [:organization_id])
  end
end
