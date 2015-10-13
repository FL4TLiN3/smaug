defmodule Smaug.StoryView do
  use Smaug.Web, :view

  def render("index.json", %{stories: stories}) do
    %{data: render_many(stories, Smaug.StoryView, "story.json")}
  end

  def render("show.json", %{story: story}) do
    %{data: render_one(story, Smaug.StoryView, "story.json")}
  end

  def render("story.json", %{story: story}) do
    %{id: story.id,
      title: story.title,
      author: story.author,
      cover: story.cover,
      category: %{
        id: story.category.id,
        name: story.category.name,
        order: story.category.order
      },
      published_at: story.published_at,
      description: story.description}
  end
end
