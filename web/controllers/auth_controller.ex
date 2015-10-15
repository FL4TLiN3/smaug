defmodule Smaug.AuthController do
  use Smaug.Web, :controller

  alias Smaug.User
  alias Smaug.UserProfile

  plug :put_layout, { Smaug.LayoutView, :nosidebar }

  def logout(conn, _params) do
    clear_session(conn)
    redirect conn, to: "/"
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    user = Repo.one(from u in User, where: u.email == ^user_params.email)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> put_session(:user, user)
        |> redirect(to: auth_path(conn, :profile))
      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
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
        |> redirect(to: auth_path(conn, :new))
      {:error, changeset} ->
        render(conn, :profile, changeset: changeset)
    end
  end

end
