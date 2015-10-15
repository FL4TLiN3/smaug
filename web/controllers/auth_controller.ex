defmodule Smaug.AuthController do
  use Smaug.Web, :controller

  alias Smaug.User
  alias Smaug.UserProfile

  plug :put_layout, { Smaug.LayoutView, :nosidebar }

  def show_login(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, :login, changeset: changeset)
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
      changeset = User.changeset(%User{}, params)
      render(conn, :new, changeset: changeset)
    end
  end

  def logout(conn, _params) do
    conn
    |> clear_session
    |> redirect to: page_path(conn, :spa)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
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
