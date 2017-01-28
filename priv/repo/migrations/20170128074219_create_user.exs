defmodule GreenHR.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :first_name, :string
      add :last_name, :string
      add :encrypted_password, :string

      add :organization_id, references(:organizations)
      add :group_id, references(:groups)
      
      timestamps()
    end

    create index(:users, [:organization_id])
    create index(:users, [:group_id])

    create unique_index(:users, [:username])
    create unique_index(:users, [:email])
  end
end
