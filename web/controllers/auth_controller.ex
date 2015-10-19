defmodule Smaug.AuthController do
  use Smaug.Web, :controller

  alias Smaug.Auth.GitHub
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
        Repo.insert! %UserProfile{
          "user_id": user.id
        }

        conn
        |> put_flash(:info, "User created successfully.")
        |> put_session(:user, user)
        |> redirect(to: auth_path(conn, :profile))
      {:error, changeset} ->
        conn
        |> render(:new, changeset: changeset)
    end
  end

  def auth_github(conn, _params) do
    conn
    |> redirect external: GitHub.authorize_url!
  end

  def auth_callback_github(conn, %{"code" => code}) do
    token = GitHub.get_token!(code: code)
    github_user = OAuth2.AccessToken.get!(token, "/user")
    user = Repo.one(from u in User, where: u.email == ^github_user["email"])

    if user do
      conn
      |> login_with_github(user, token, github_user)
    else
      conn
      |> signup_with_github(token, github_user)
    end

  end

  defp login_with_github(conn, user, token, github_user) do
    conn
    |> put_session(:user, user)
    |> redirect(to: page_path(conn, :spa))
  end

  defp signup_with_github(conn, token, github_user) do
    user = Repo.insert! User.changeset(%User{}, %{
      "email": github_user["email"],
      "github_access_token": token.access_token
    })

    Repo.insert! %UserProfile{
      "user_id": user.id,
      "name": github_user["name"],
      "location": github_user["location"],
      "bio": github_user["bio"]
    }

    conn
    |> put_flash(:info, "User created successfully.")
    |> put_session(:user, user)
    |> redirect(to: auth_path(conn, :profile))
  end

  def profile(conn, _params) do
    user = get_session(conn, :user)
    user_profile = Repo.one(from up in UserProfile, where: up.user_id == ^user.id)
    changeset = UserProfile.changeset(user_profile)

    conn
    |> render(:profile, user_profile: user_profile, changeset: changeset)
  end

  def update_profile(conn, %{"user_profile" => user_profile_params}) do
    user_profile = Repo.get!(UserProfile, user_profile_params["user_id"])
    changeset = UserProfile.changeset(user_profile, user_profile_params)

    case Repo.update(changeset) do
      {:ok, _user_profile} ->
        conn
        |> put_flash(:info, "UserProfile created successfully.")
        |> redirect(to: page_path(conn, :spa))
      {:error, changeset} ->
        conn
        |> render(:profile, user_profile: user_profile, changeset: changeset)
    end
  end

end
