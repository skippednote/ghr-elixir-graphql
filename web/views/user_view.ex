defmodule GreenHR.UserView do
  use GreenHR.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, GreenHR.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, GreenHR.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at,
      organization_id: user.organization_id
    }
  end
end
