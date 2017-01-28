defmodule GreenHR.User do
  use GreenHR.Web, :model

  schema "users" do
    field :username, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true

    belongs_to :organization, GreenHR.Organization
    belongs_to :group, GreenHR.Group

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :email, :first_name, :last_name, :organization_id])
    |> validate_required([:username, :email, :first_name, :last_name, :organization_id])
    |> validate_length(:username, min: 1, max: 20)    
    |> update_change(:username, &String.downcase/1)
    |> unique_constraint(:username)
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase/1)    
    |> unique_constraint(:email)
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, [:password])
    |> validate_length(:password, min: 6, max: 100)
    |> put_encrypted_pw
  end

  defp put_encrypted_pw(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
