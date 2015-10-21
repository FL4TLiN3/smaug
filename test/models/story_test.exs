defmodule Smaug.StoryTest do
  use Smaug.ModelCase

  alias Smaug.Story

  @valid_attrs %{
    title: "今まで続かなかった、ランニングを日課にする「5つの方法」",
    author: "中野ジェームズ修一",
    cover: "story-cover-1.jpg",
    published_at: "2015-10-01 00:00:00",
    description: "some content",
    category_id: 1
  }
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
