defmodule Smaug.FeedTest do
  use Smaug.ModelCase

  alias Smaug.Feed

  @valid_attrs %{etag: "some content", last_fetched_at: "2010-04-17 14:00:00", name: "some content", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Feed.changeset(%Feed{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Feed.changeset(%Feed{}, @invalid_attrs)
    refute changeset.valid?
  end
end
