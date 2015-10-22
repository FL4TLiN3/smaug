defmodule Smaug.Worker.FetchRss do
  use Smaug.Web, :worker

  def perform do
    IO.inspect("test")
  end
end
