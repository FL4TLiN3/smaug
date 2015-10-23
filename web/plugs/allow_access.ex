defmodule Smaug.Plug.AllowAccess do
  import Plug.Conn

  def init(default), do: default

  def call(conn, default) do
    case conn.peer do
      {{127, 0, 0, 1}, _} ->
        conn
      {{192, 168, _, _}, _} ->
        if default == [:localhost] do
          send400 conn
        else
          conn
        end
      _ ->
        if default == [:localhost] or default == [:internal] do
          send400 conn
        else
          conn
        end
    end
  end

  defp send400(conn) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(400, "Bad Request")
  end
end
