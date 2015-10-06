defmodule Smaug.PageController do
  use Smaug.Web, :controller

  def spa(conn, _params) do
    render conn, "spa.html"
  end
end
