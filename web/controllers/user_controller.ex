defmodule GreenHR.UserController do
  use GreenHR.Web, :controller

  alias GreenHR.User
  import Ecto.Query

  def index(conn, %{"organization_id" => oid}) do
    users = Repo.all(
      from u in User,
      where: u.organization_id == ^oid
    )
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params, "organization_id" => oid}) do
    changeset = User.changeset(%User{}, Map.put(user_params, "organization_id", oid))

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", organization_user_path(conn, :show, oid, user))
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(GreenHR.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        render(conn, "show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(GreenHR.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    Repo.delete!(user)

    send_resp(conn, :no_content, "")
  end
end
