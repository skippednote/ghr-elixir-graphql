defmodule GreenHR.PageController do
  use GreenHR.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
