defmodule Smaug.AuthController do
  use Smaug.Web, :controller
  import Ecto.Changeset

  alias Smaug.User
  alias Smaug.UserProfile
  alias Timex.Date
  alias Timex.DateFormat
  alias Timex.Time

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
        conf = Mix.Config.read!("config/config.exs")
        access_secret_generated_at = Date.now
        access_token_expires_at = access_secret_generated_at |> Date.add(Time.to_timestamp(30, :days))

        access_secret =
          :crypto.hash(
            :sha256,
            [user.id, access_secret_generated_at |> DateFormat.format!("{ISO}"), conf[:smaug][:hash_salt]])
          |> Base.encode16

        access_token =
          :crypto.hash(
            :sha256,
            [access_secret, access_token_expires_at |> DateFormat.format!("{ISO}"), conf[:smaug][:hash_salt]])
          |> Base.encode16

        Repo.update! %{user |
          access_secret: access_secret,
          access_secret_generated_at: access_secret_generated_at,
          access_token: access_token,
          access_token_expires_at: access_token_expires_at
        }

        Repo.insert! %UserProfile{user_id: user.id}

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
