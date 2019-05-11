defmodule Newzjunky.ArticlesTest do
  use Newzjunky.DataCase

  alias Newzjunky.Articles

  describe "stories" do
    alias Newzjunky.Articles.Story

    @valid_attrs %{content: "some content", description: "some description", imageUrl: "some imageUrl", publishedAt: "2010-04-17T14:00:00Z", title: "some title", url: "some url"}
    @update_attrs %{content: "some updated content", description: "some updated description", imageUrl: "some updated imageUrl", publishedAt: "2011-05-18T15:01:01Z", title: "some updated title", url: "some updated url"}
    @invalid_attrs %{content: nil, description: nil, imageUrl: nil, publishedAt: nil, title: nil, url: nil}

    def story_fixture(attrs \\ %{}) do
      {:ok, story} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Articles.create_story()

      story
    end

    test "list_stories/0 returns all stories" do
      story = story_fixture()
      assert Articles.list_stories() == [story]
    end

    test "get_story!/1 returns the story with given id" do
      story = story_fixture()
      assert Articles.get_story!(story.id) == story
    end

    test "create_story/1 with valid data creates a story" do
      assert {:ok, %Story{} = story} = Articles.create_story(@valid_attrs)
      assert story.content == "some content"
      assert story.description == "some description"
      assert story.imageUrl == "some imageUrl"
      assert story.publishedAt == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert story.title == "some title"
      assert story.url == "some url"
    end

    test "create_story/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Articles.create_story(@invalid_attrs)
    end

    test "update_story/2 with valid data updates the story" do
      story = story_fixture()
      assert {:ok, %Story{} = story} = Articles.update_story(story, @update_attrs)
      assert story.content == "some updated content"
      assert story.description == "some updated description"
      assert story.imageUrl == "some updated imageUrl"
      assert story.publishedAt == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert story.title == "some updated title"
      assert story.url == "some updated url"
    end

    test "update_story/2 with invalid data returns error changeset" do
      story = story_fixture()
      assert {:error, %Ecto.Changeset{}} = Articles.update_story(story, @invalid_attrs)
      assert story == Articles.get_story!(story.id)
    end

    test "delete_story/1 deletes the story" do
      story = story_fixture()
      assert {:ok, %Story{}} = Articles.delete_story(story)
      assert_raise Ecto.NoResultsError, fn -> Articles.get_story!(story.id) end
    end

    test "change_story/1 returns a story changeset" do
      story = story_fixture()
      assert %Ecto.Changeset{} = Articles.change_story(story)
    end
  end

  describe "sources" do
    alias Newzjunky.Articles.Source

    @valid_attrs %{oid: "some oid", title: "some title"}
    @update_attrs %{oid: "some updated oid", title: "some updated title"}
    @invalid_attrs %{oid: nil, title: nil}

    def source_fixture(attrs \\ %{}) do
      {:ok, source} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Articles.create_source()

      source
    end

    test "list_sources/0 returns all sources" do
      source = source_fixture()
      assert Articles.list_sources() == [source]
    end

    test "get_source!/1 returns the source with given id" do
      source = source_fixture()
      assert Articles.get_source!(source.id) == source
    end

    test "create_source/1 with valid data creates a source" do
      assert {:ok, %Source{} = source} = Articles.create_source(@valid_attrs)
      assert source.oid == "some oid"
      assert source.title == "some title"
    end

    test "create_source/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Articles.create_source(@invalid_attrs)
    end

    test "update_source/2 with valid data updates the source" do
      source = source_fixture()
      assert {:ok, %Source{} = source} = Articles.update_source(source, @update_attrs)
      assert source.oid == "some updated oid"
      assert source.title == "some updated title"
    end

    test "update_source/2 with invalid data returns error changeset" do
      source = source_fixture()
      assert {:error, %Ecto.Changeset{}} = Articles.update_source(source, @invalid_attrs)
      assert source == Articles.get_source!(source.id)
    end

    test "delete_source/1 deletes the source" do
      source = source_fixture()
      assert {:ok, %Source{}} = Articles.delete_source(source)
      assert_raise Ecto.NoResultsError, fn -> Articles.get_source!(source.id) end
    end

    test "change_source/1 returns a source changeset" do
      source = source_fixture()
      assert %Ecto.Changeset{} = Articles.change_source(source)
    end
  end

  describe "authors" do
    alias Newzjunky.Articles.Author

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def author_fixture(attrs \\ %{}) do
      {:ok, author} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Articles.create_author()

      author
    end

    test "list_authors/0 returns all authors" do
      author = author_fixture()
      assert Articles.list_authors() == [author]
    end

    test "get_author!/1 returns the author with given id" do
      author = author_fixture()
      assert Articles.get_author!(author.id) == author
    end

    test "create_author/1 with valid data creates a author" do
      assert {:ok, %Author{} = author} = Articles.create_author(@valid_attrs)
      assert author.name == "some name"
    end

    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Articles.create_author(@invalid_attrs)
    end

    test "update_author/2 with valid data updates the author" do
      author = author_fixture()
      assert {:ok, %Author{} = author} = Articles.update_author(author, @update_attrs)
      assert author.name == "some updated name"
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = author_fixture()
      assert {:error, %Ecto.Changeset{}} = Articles.update_author(author, @invalid_attrs)
      assert author == Articles.get_author!(author.id)
    end

    test "delete_author/1 deletes the author" do
      author = author_fixture()
      assert {:ok, %Author{}} = Articles.delete_author(author)
      assert_raise Ecto.NoResultsError, fn -> Articles.get_author!(author.id) end
    end

    test "change_author/1 returns a author changeset" do
      author = author_fixture()
      assert %Ecto.Changeset{} = Articles.change_author(author)
    end
  end

  describe "tags" do
    alias Newzjunky.Articles.Tag

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def tag_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Articles.create_tag()

      tag
    end

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Articles.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Articles.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      assert {:ok, %Tag{} = tag} = Articles.create_tag(@valid_attrs)
      assert tag.name == "some name"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Articles.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{} = tag} = Articles.update_tag(tag, @update_attrs)
      assert tag.name == "some updated name"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Articles.update_tag(tag, @invalid_attrs)
      assert tag == Articles.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Articles.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Articles.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Articles.change_tag(tag)
    end
  end
end
