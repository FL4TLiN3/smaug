defmodule Smaug.Router do
  use Smaug.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_layout, { Smaug.LayoutView, :app }
  end

  pipeline :admin do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_layout, { Smaug.LayoutView, :admin }
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Smaug do
    pipe_through :browser

    get "/", PageController, :spa
    get "/signup", SignupController, :index
    post "/signup", SignupController, :create
    get "/signup/profile", SignupController, :profile
    post "/signup/profile", SignupController, :update_profile
    get "/stories", PageController, :spa
    get "/stories/:id", PageController, :spa
  end

  scope "/admin", Smaug do
    pipe_through :admin

    get "/", PageController, :spa
    resources "/stories", StoryController
    resources "/categories", CategoryController
    resources "/users", UserController
  end

  scope "/api", Smaug do
    pipe_through :api

    resources "/stories", StoryController, only: [:index, :show]
  end
end
