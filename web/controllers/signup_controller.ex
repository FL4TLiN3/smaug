defmodule Smaug.SignupController do
  use Smaug.Web, :controller

  alias Smaug.User

  plug :put_layout, { Smaug.LayoutView, :nosidebar }

  def index(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, :index, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: signup_path(conn, :index))
      {:error, changeset} ->
        render(conn, :index, changeset: changeset)
    end
  end
end
