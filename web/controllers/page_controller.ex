defmodule Smaug.PageController do
  use Smaug.Web, :controller

  def spa(conn, _params) do
    user = get_session(conn, :user)
    render(conn, :spa, user: user)
  end
end
