defmodule Smaug.Router do
  use Smaug.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end


  scope "/", Smaug do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :spa
    get "/stories/:id", PageController, :spa
  end

  scope "/admin", Smaug do
    pipe_through :admin

    resources "/stories", StoryController
  end

  scope "/api", Smaug do
    pipe_through :api

    resources "/stories", StoryController, only: [:index, :show]
  end
end
