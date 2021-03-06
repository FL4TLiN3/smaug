defmodule Smaug.FeedControllerTest do
  use Smaug.ConnCase

  alias Smaug.Feed
  @valid_attrs %{etag: "some content", last_fetched_at: "2010-04-17 14:00:00", name: "some content", url: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, feed_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing feeds"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, feed_path(conn, :new)
    assert html_response(conn, 200) =~ "New feed"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, feed_path(conn, :create), feed: @valid_attrs
    assert redirected_to(conn) == feed_path(conn, :index)
    assert Repo.get_by(Feed, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, feed_path(conn, :create), feed: @invalid_attrs
    assert html_response(conn, 200) =~ "New feed"
  end

  test "shows chosen resource", %{conn: conn} do
    feed = Repo.insert! %Feed{}
    conn = get conn, feed_path(conn, :show, feed)
    assert html_response(conn, 200) =~ "Show feed"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, feed_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    feed = Repo.insert! %Feed{}
    conn = get conn, feed_path(conn, :edit, feed)
    assert html_response(conn, 200) =~ "Edit feed"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    feed = Repo.insert! %Feed{}
    conn = put conn, feed_path(conn, :update, feed), feed: @valid_attrs
    assert redirected_to(conn) == feed_path(conn, :show, feed)
    assert Repo.get_by(Feed, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    feed = Repo.insert! %Feed{}
    conn = put conn, feed_path(conn, :update, feed), feed: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit feed"
  end

  test "deletes chosen resource", %{conn: conn} do
    feed = Repo.insert! %Feed{}
    conn = delete conn, feed_path(conn, :delete, feed)
    assert redirected_to(conn) == feed_path(conn, :index)
    refute Repo.get(Feed, feed.id)
  end
end
