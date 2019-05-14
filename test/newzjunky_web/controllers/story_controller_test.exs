defmodule NewzjunkyWeb.StoryControllerTest do
  use NewzjunkyWeb.ConnCase

  alias Newzjunky.Stories
  alias Newzjunky.Stories.Story

  @create_attrs %{
    content: "some content",
    description: "some description",
    publishedAt: "2010-04-17T14:00:00Z",
    title: "some title",
    url: "some url",
    urlToImage: "some urlToImage"
  }
  @update_attrs %{
    content: "some updated content",
    description: "some updated description",
    publishedAt: "2011-05-18T15:01:01Z",
    title: "some updated title",
    url: "some updated url",
    urlToImage: "some updated urlToImage"
  }
  @invalid_attrs %{content: nil, description: nil, publishedAt: nil, title: nil, url: nil, urlToImage: nil}

  def fixture(:story) do
    {:ok, story} = Stories.create_story(@create_attrs)
    story
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all stories", %{conn: conn} do
      conn = get(conn, Routes.story_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create story" do
    test "renders story when data is valid", %{conn: conn} do
      conn = post(conn, Routes.story_path(conn, :create), story: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.story_path(conn, :show, id))

      assert %{
               "id" => id,
               "content" => "some content",
               "description" => "some description",
               "publishedAt" => "2010-04-17T14:00:00Z",
               "title" => "some title",
               "url" => "some url",
               "urlToImage" => "some urlToImage"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.story_path(conn, :create), story: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update story" do
    setup [:create_story]

    test "renders story when data is valid", %{conn: conn, story: %Story{id: id} = story} do
      conn = put(conn, Routes.story_path(conn, :update, story), story: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.story_path(conn, :show, id))

      assert %{
               "id" => id,
               "content" => "some updated content",
               "description" => "some updated description",
               "publishedAt" => "2011-05-18T15:01:01Z",
               "title" => "some updated title",
               "url" => "some updated url",
               "urlToImage" => "some updated urlToImage"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, story: story} do
      conn = put(conn, Routes.story_path(conn, :update, story), story: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete story" do
    setup [:create_story]

    test "deletes chosen story", %{conn: conn, story: story} do
      conn = delete(conn, Routes.story_path(conn, :delete, story))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.story_path(conn, :show, story))
      end
    end
  end

  defp create_story(_) do
    story = fixture(:story)
    {:ok, story: story}
  end
end
