defmodule GreenHR.Router do
  use GreenHR.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GreenHR do
    pipe_through :browser
  end

  scope "/api", GreenHR do
    pipe_through :api

    resources "/organizations", OrganizationController, except: [:new, :edit] do
      resources "/groups", GroupController, except: [:new, :edit]
      resources "/users", UserController, except: [:new, :edit]      
    end
  end
end
