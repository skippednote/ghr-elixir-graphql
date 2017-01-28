defmodule GreenHR.Group do
  use GreenHR.Web, :model

  schema "groups" do
    field :name, :string
    
    belongs_to :organization, GreenHR.Organization

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :organization_id])
    |> validate_required([:name])
  end
end
