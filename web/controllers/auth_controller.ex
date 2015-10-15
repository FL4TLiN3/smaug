defmodule Smaug.AuthController do
  use Smaug.Web, :controller

  alias Smaug.User
  alias Smaug.UserProfile

  plug :put_layout, { Smaug.LayoutView, :nosidebar }

  def show_login(conn, _params) do
    conn
    |> render(:login, changeset: User.changeset(%User{}))
  end

  def login(conn, %{"user" => %{"email" => email, "password" => password} = params}) do
    conf = Mix.Config.read!("config/config.exs")
    password = :crypto.hash(:sha256, [password, conf[:smaug][:hash_salt]]) |> Base.encode16
    user = Repo.one(from u in User, where: u.email == ^email and u.password == ^password)
    if user do
      conn
      |> put_session(:user, user)
      |> redirect(to: "/")
    else
      conn
      |> render(:login, changeset: User.changeset(%User{}, params))
    end
  end

  def logout(conn, _params) do
    conn
    |> clear_session
    |> redirect to: page_path(conn, :spa)
  end

  def new(conn, _params) do
    conn
    |> render(:new, changeset: User.changeset(%User{}))
  end

  def create(conn, %{"user" => params}) do
    changeset = User.changeset(%User{}, params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> put_session(:user, user)
        |> redirect(to: auth_path(conn, :profile))
      {:error, changeset} ->
        conn
        |> render(:new, changeset: changeset)
    end
  end

  def profile(conn, _params) do
    case user = conn |> get_session :user do
      %User{id: id} ->
        conn
        |> render(:profile, changeset: UserProfile.changeset(%UserProfile{}, %{user_id: id}))
    end
  end

  def update_profile(conn, %{"user_profile" => user_profile_params}) do
    changeset = UserProfile.changeset(%UserProfile{}, user_profile_params)
    case Repo.insert(changeset) do
      {:ok, _user_profile} ->
        conn
        |> put_flash(:info, "UserProfile created successfully.")
        |> redirect(to: page_path(conn, :spa))
      {:error, changeset} ->
        conn
        |> render(:profile, changeset: changeset)
    end
  end

end
