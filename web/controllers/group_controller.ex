defmodule GreenHR.GroupController do
  use GreenHR.Web, :controller

  alias GreenHR.Group

  def index(conn, %{"organization_id" => oid}) do
    groups = Repo.all(
      from g in Group,
      where: g.organization_id == ^oid
    )
    render(conn, "index.json", groups: groups)
  end

  def create(conn, %{"group" => group_params, "organization_id" => oid}) do
    changeset = Group.changeset(%Group{}, Map.put(group_params, "organization_id", oid))

    case Repo.insert(changeset) do
      {:ok, group} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", organization_group_path(conn, :show, oid, group))
        |> render("show.json", group: group)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(GreenHR.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    group = Repo.get!(Group, id)
    render(conn, "show.json", group: group)
  end

  def update(conn, %{"id" => id, "group" => group_params}) do
    group = Repo.get!(Group, id)
    changeset = Group.changeset(group, group_params)

    case Repo.update(changeset) do
      {:ok, group} ->
        render(conn, "show.json", group: group)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(GreenHR.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    group = Repo.get!(Group, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(group)

    send_resp(conn, :no_content, "")
  end
end
