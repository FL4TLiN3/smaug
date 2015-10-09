defmodule Smaug.PageControllerTest do
  use Smaug.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "The News"
  end

  test "GET /stories/:id" do
    conn = get conn(), "/stories/1"
    assert html_response(conn, 200) =~ "The News"
  end
end
