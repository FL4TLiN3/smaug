defmodule Smaug.StoryTest do
  use Smaug.ModelCase

  alias Smaug.Story

  @valid_attrs %{author: "some content", cover: "some content", description: "some content", published_at: "2010-04-17 14:00:00", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Story.changeset(%Story{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Story.changeset(%Story{}, @invalid_attrs)
    refute changeset.valid?
  end
end
