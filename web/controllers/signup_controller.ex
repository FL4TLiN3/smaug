defmodule Smaug.SignupController do
  use Smaug.Web, :controller

  plug :put_layout, { Smaug.LayoutView, :nosidebar }

  def index(conn, _params) do
    render conn, :index
  end

  # def new(conn, _params) do
    # changeset = Story.changeset(%Story{})
    # render(conn, "new.html", changeset: changeset)
  # end
end
