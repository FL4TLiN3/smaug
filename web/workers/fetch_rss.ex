defmodule Smaug.Worker.FetchRss do
  use Smaug.Web, :worker

  alias Smaug.Service.Feed
  alias Smaug.Story

  def perform do
    feed = Repo.one(from f in Smaug.Feed, order_by: [f.last_fetched_at], limit: 1)
    body = Feed.get(feed.url).body

    saveStory body.stories
  end

  def saveStory([head|tail]) do
    story = Repo.one(from s in Story, where: s.original_link == ^head.original_link, limit: 1)

    if story do
      story |> Story.changeset(head) |> Repo.update!
    else
      %Story{} |> Story.changeset(head) |> Repo.insert!
    end

    saveStory tail
  end

  def saveStory(_), do: nil
end
