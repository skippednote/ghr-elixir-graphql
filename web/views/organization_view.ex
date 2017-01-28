defmodule GreenHR.OrganizationView do
  use GreenHR.Web, :view

  def render("index.json", %{organizations: organizations}) do
    %{data: render_many(organizations, GreenHR.OrganizationView, "organization.json")}
  end

  def render("show.json", %{organization: organization}) do
    %{data: render_one(organization, GreenHR.OrganizationView, "organization.json")}
  end

  def render("organization.json", %{organization: organization}) do
    %{id: organization.id,
      name: organization.name}
  end
end
