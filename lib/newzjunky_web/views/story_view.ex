defmodule NewzjunkyWeb.StoryView do
  use NewzjunkyWeb, :view
  alias NewzjunkyWeb.StoryView

  def render("index.json", %{stories: stories}) do
    %{data: render_many(stories, StoryView, "story.json")}
  end

  def render("show.json", %{story: story}) do
    %{data: render_one(story, StoryView, "story.json")}
  end

  def render("story.json", %{story: story}) do
    %{id: story.id,
      title: story.title,
      description: story.description,
      content: story.content,
      url: story.url,
      urlToImage: story.urlToImage,
      publishedAt: story.publishedAt}
  end
end
