defmodule Smaug.Credential do

  alias Smaug.User
  alias Timex.Date
  alias Timex.DateFormat
  alias Timex.Time

  def get_credentials(user) do
    secret = get_access_secret user
    token  = get_access_token secret
    Dict.merge(secret, token)
  end

  def get_access_secret(%User{id: id}) do
    conf = Mix.Config.read!("config/config.exs")
    access_secret_generated_at = Date.now
    raw_access_secret = [
      id,
      access_secret_generated_at |> DateFormat.format!("{ISO}"),
      conf[:smaug][:hash_salt]
    ]
    access_secret = :crypto.hash(:sha256, raw_access_secret) |> Base.encode16
    %{access_secret: access_secret, access_secret_generated_at: access_secret_generated_at}
  end

  def get_access_token(%{access_secret: access_secret, access_secret_generated_at: access_secret_generated_at}) do
    conf = Mix.Config.read!("config/config.exs")
    access_token_expires_at = access_secret_generated_at |> Date.add(Time.to_timestamp(30, :days))
    raw_access_token = [
      access_secret,
      access_token_expires_at |> DateFormat.format!("{ISO}"),
      conf[:smaug][:hash_salt]
    ]
    access_token = :crypto.hash(:sha256, raw_access_token) |> Base.encode16
    %{access_token: access_token, access_token_expires_at: access_token_expires_at}
  end
end
