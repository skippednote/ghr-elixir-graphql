defmodule GreenHR.GroupView do
  use GreenHR.Web, :view

  def render("index.json", %{groups: groups}) do
    %{data: render_many(groups, GreenHR.GroupView, "group.json")}
  end

  def render("show.json", %{group: group}) do
    %{data: render_one(group, GreenHR.GroupView, "group.json")}
  end

  def render("group.json", %{group: group}) do
    %{id: group.id,
      name: group.name,
      organization_id: group.organization_id}
  end
end
