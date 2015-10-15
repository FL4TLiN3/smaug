defmodule Smaug.SignupController do
  use Smaug.Web, :controller

  alias Smaug.User
  alias Smaug.UserProfile

  plug :put_layout, { Smaug.LayoutView, :nosidebar }

  def index(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, :index, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> put_session(:user, user)
        |> redirect(to: signup_path(conn, :profile))
      {:error, changeset} ->
        render(conn, :index, changeset: changeset)
    end
  end

  def profile(conn, _params) do
    case get_session(conn, :user) do
      %User{id: id} ->
        changeset = UserProfile.changeset(%UserProfile{}, %{user_id: id})
    end
    render(conn, :profile, changeset: changeset)
  end

  def update_profile(conn, %{"user_profile" => user_profile_params}) do

    case get_session(conn, :user) do
      %User{id: id} ->
        changeset = UserProfile.changeset(%UserProfile{}, user_profile_params)
    end

    case Repo.insert(changeset) do
      {:ok, _user_profile} ->
        conn
        |> put_flash(:info, "UserProfile created successfully.")
        |> redirect(to: signup_path(conn, :index))
      {:error, changeset} ->
        render(conn, :profile, changeset: changeset)
    end
  end

end
