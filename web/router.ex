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

    get  "/", PageController, :spa
    get  "/login", AuthController, :show_login
    post "/login", AuthController, :login
    get  "/logout", AuthController, :logout
    get  "/auth/github", AuthGithubController, :auth
    get  "/auth/callback/github", AuthGithubController, :auth_callback
    get  "/signup", AuthController, :new
    post "/signup", AuthController, :create
    get  "/signup/profile", AuthController, :profile
    post "/signup/profile", AuthController, :update_profile
    put  "/signup/profile", AuthController, :update_profile
    get  "/stories", PageController, :spa
    get  "/stories/:id", PageController, :spa
  end

  scope "/admin", Smaug do
    pipe_through :admin

    get "/", PageController, :spa
    resources "/stories", StoryController
    resources "/categories", CategoryController
    resources "/users", UserController
    resources "/feeds", FeedController
  end

  scope "/api", Smaug do
    pipe_through :api

    get  "/job/stats", JobController, :stats
    post "/job", JobController, :create
    resources "/stories", StoryController, only: [:index, :show]
  end
end
