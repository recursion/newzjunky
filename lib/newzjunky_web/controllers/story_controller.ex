defmodule NewzjunkyWeb.StoryController do
  use NewzjunkyWeb, :controller
  require Logger

  alias Newzjunky.Stories
  alias Newzjunky.Stories.Story

  action_fallback NewzjunkyWeb.FallbackController

  def index(conn, _params) do
    Logger.info("Populating stories")
    HTTPoison.start()
    r = HTTPoison.get!(Newzjunky.Config.url())
    body = Jason.decode!(r.body)

    stories =
      body["articles"]
      |> Enum.map(fn story ->
        %Story{
          title: story["title"],
          url: story["url"],
          urlToImage: story["urlToImage"],
          description: story["description"],
          content: story["content"],
          author: story["author"]
        }
      end)

    story_count = body["totalResults"]
    render(conn, "index.json", stories: stories)
  end

  def create(conn, %{"story" => story_params}) do
    with {:ok, %Story{} = story} <- Stories.create_story(story_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.story_path(conn, :show, story))
      |> render("show.json", story: story)
    end
  end

  def show(conn, %{"id" => id}) do
    story = Stories.get_story!(id)
    render(conn, "show.json", story: story)
  end

  def update(conn, %{"id" => id, "story" => story_params}) do
    story = Stories.get_story!(id)

    with {:ok, %Story{} = story} <- Stories.update_story(story, story_params) do
      render(conn, "show.json", story: story)
    end
  end

  def delete(conn, %{"id" => id}) do
    story = Stories.get_story!(id)

    with {:ok, %Story{}} <- Stories.delete_story(story) do
      send_resp(conn, :no_content, "")
    end
  end
end
