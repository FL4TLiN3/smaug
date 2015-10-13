defmodule Smaug.PageController do
  use Smaug.Web, :controller

  plug :put_layout, :admin

  def spa(conn, _params) do
    render conn, :spa
  end
end
