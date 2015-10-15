defmodule Smaug.UserProfileTest do
  use Smaug.ModelCase

  alias Smaug.UserProfile

  @valid_attrs %{bio: "some content", location: "some content", name: "some content", user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserProfile.changeset(%UserProfile{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserProfile.changeset(%UserProfile{}, @invalid_attrs)
    refute changeset.valid?
  end
end
