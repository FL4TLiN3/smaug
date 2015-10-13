defmodule Smaug.CategoryTest do
  use Smaug.ModelCase

  alias Smaug.Category

  @valid_attrs %{name: "some content", order: 42, published: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Category.changeset(%Category{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Category.changeset(%Category{}, @invalid_attrs)
    refute changeset.valid?
  end
end
