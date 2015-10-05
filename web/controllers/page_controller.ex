defmodule Smaug.PageController do
  use Smaug.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
