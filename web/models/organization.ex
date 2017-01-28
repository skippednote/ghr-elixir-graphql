defmodule GreenHR.Organization do
  use GreenHR.Web, :model

  schema "organizations" do
    field :name, :string

    has_many :groups, GreenHR.Group
    has_many :users, GreenHR.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
