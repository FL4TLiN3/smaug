defmodule Smaug.UserTest do
  use Smaug.ModelCase

  alias Smaug.User

  @valid_attrs %{access_secret: "some content", access_secret_generated_at: "2010-04-17 14:00:00", access_token: "some content", access_token_expires_at: "2010-04-17 14:00:00", email: "some content", facebook_access_token: "some content", name: "some content", password: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
