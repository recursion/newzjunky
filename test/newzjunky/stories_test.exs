defmodule Newzjunky.StoriesTest do
  use Newzjunky.DataCase

  alias Newzjunky.Stories

  describe "stories" do
    alias Newzjunky.Stories.Story

    @valid_attrs %{author: "some author", content: "some content", description: "some description", publishedAt: "2010-04-17T14:00:00Z", source: "some source", title: "some title", url: "some url", urlToImage: "some urlToImage"}
    @update_attrs %{author: "some updated author", content: "some updated content", description: "some updated description", publishedAt: "2011-05-18T15:01:01Z", source: "some updated source", title: "some updated title", url: "some updated url", urlToImage: "some updated urlToImage"}
    @invalid_attrs %{author: nil, content: nil, description: nil, publishedAt: nil, source: nil, title: nil, url: nil, urlToImage: nil}

    def story_fixture(attrs \\ %{}) do
      {:ok, story} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Stories.create_story()

      story
    end

    test "list_stories/0 returns all stories" do
      story = story_fixture()
      assert Stories.list_stories() == [story]
    end

    test "get_story!/1 returns the story with given id" do
      story = story_fixture()
      assert Stories.get_story!(story.id) == story
    end

    test "create_story/1 with valid data creates a story" do
      assert {:ok, %Story{} = story} = Stories.create_story(@valid_attrs)
      assert story.author == "some author"
      assert story.content == "some content"
      assert story.description == "some description"
      assert story.publishedAt == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert story.source == "some source"
      assert story.title == "some title"
      assert story.url == "some url"
      assert story.urlToImage == "some urlToImage"
    end

    test "create_story/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stories.create_story(@invalid_attrs)
    end

    test "update_story/2 with valid data updates the story" do
      story = story_fixture()
      assert {:ok, %Story{} = story} = Stories.update_story(story, @update_attrs)
      assert story.author == "some updated author"
      assert story.content == "some updated content"
      assert story.description == "some updated description"
      assert story.publishedAt == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert story.source == "some updated source"
      assert story.title == "some updated title"
      assert story.url == "some updated url"
      assert story.urlToImage == "some updated urlToImage"
    end

    test "update_story/2 with invalid data returns error changeset" do
      story = story_fixture()
      assert {:error, %Ecto.Changeset{}} = Stories.update_story(story, @invalid_attrs)
      assert story == Stories.get_story!(story.id)
    end

    test "delete_story/1 deletes the story" do
      story = story_fixture()
      assert {:ok, %Story{}} = Stories.delete_story(story)
      assert_raise Ecto.NoResultsError, fn -> Stories.get_story!(story.id) end
    end

    test "change_story/1 returns a story changeset" do
      story = story_fixture()
      assert %Ecto.Changeset{} = Stories.change_story(story)
    end
  end
end
