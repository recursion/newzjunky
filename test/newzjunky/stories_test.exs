defmodule Newzjunky.StoriesTest do
  use Newzjunky.DataCase

  alias Newzjunky.Stories

  describe "authors" do
    alias Newzjunky.Stories.Author

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def author_fixture(attrs \\ %{}) do
      {:ok, author} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Stories.create_author()

      author
    end

    test "list_authors/0 returns all authors" do
      author = author_fixture()
      assert Stories.list_authors() == [author]
    end

    test "get_author!/1 returns the author with given id" do
      author = author_fixture()
      assert Stories.get_author!(author.id) == author
    end

    test "create_author/1 with valid data creates a author" do
      assert {:ok, %Author{} = author} = Stories.create_author(@valid_attrs)
      assert author.name == "some name"
    end

    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stories.create_author(@invalid_attrs)
    end

    test "update_author/2 with valid data updates the author" do
      author = author_fixture()
      assert {:ok, %Author{} = author} = Stories.update_author(author, @update_attrs)
      assert author.name == "some updated name"
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = author_fixture()
      assert {:error, %Ecto.Changeset{}} = Stories.update_author(author, @invalid_attrs)
      assert author == Stories.get_author!(author.id)
    end

    test "delete_author/1 deletes the author" do
      author = author_fixture()
      assert {:ok, %Author{}} = Stories.delete_author(author)
      assert_raise Ecto.NoResultsError, fn -> Stories.get_author!(author.id) end
    end

    test "change_author/1 returns a author changeset" do
      author = author_fixture()
      assert %Ecto.Changeset{} = Stories.change_author(author)
    end
  end

  describe "stories" do
    alias Newzjunky.Stories.Story

    @valid_attrs %{
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
    @invalid_attrs %{
      content: nil,
      description: nil,
      publishedAt: nil,
      title: nil,
      url: nil,
      urlToImage: nil
    }

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
      assert story.content == "some content"
      assert story.description == "some description"
      assert story.publishedAt == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
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
      assert story.content == "some updated content"
      assert story.description == "some updated description"
      assert story.publishedAt == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
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

  describe "urls" do
    alias Newzjunky.Stories.Url

    @valid_attrs %{address: "some address"}
    @update_attrs %{address: "some updated address"}
    @invalid_attrs %{address: nil}

    def url_fixture(attrs \\ %{}) do
      {:ok, url} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Stories.create_url()

      url
    end

    test "list_urls/0 returns all urls" do
      url = url_fixture()
      assert Stories.list_urls() == [url]
    end

    test "get_url!/1 returns the url with given id" do
      url = url_fixture()
      assert Stories.get_url!(url.id) == url
    end

    test "create_url/1 with valid data creates a url" do
      assert {:ok, %Url{} = url} = Stories.create_url(@valid_attrs)
      assert url.address == "some address"
    end

    test "create_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stories.create_url(@invalid_attrs)
    end

    test "update_url/2 with valid data updates the url" do
      url = url_fixture()
      assert {:ok, %Url{} = url} = Stories.update_url(url, @update_attrs)
      assert url.address == "some updated address"
    end

    test "update_url/2 with invalid data returns error changeset" do
      url = url_fixture()
      assert {:error, %Ecto.Changeset{}} = Stories.update_url(url, @invalid_attrs)
      assert url == Stories.get_url!(url.id)
    end

    test "delete_url/1 deletes the url" do
      url = url_fixture()
      assert {:ok, %Url{}} = Stories.delete_url(url)
      assert_raise Ecto.NoResultsError, fn -> Stories.get_url!(url.id) end
    end

    test "change_url/1 returns a url changeset" do
      url = url_fixture()
      assert %Ecto.Changeset{} = Stories.change_url(url)
    end
  end
end
