defmodule Newzjunky.Stories do
  @moduledoc """
  The Stories context.
  """

  require Logger
  import Ecto.Query, warn: false
  alias Newzjunky.Repo

  alias Newzjunky.Stories.{Story, Author, Url}

  @doc """
  Returns the list of authors.

  ## Examples

      iex> list_authors()
      [%Author{}, ...]

  """
  def list_authors do
    Repo.all(Author)
  end

  @doc """
  Gets a single author.

  Raises `Ecto.NoResultsError` if the Author does not exist.

  ## Examples

      iex> get_author!(123)
      %Author{}

      iex> get_author!(456)
      ** (Ecto.NoResultsError)

  """
  def get_author!(id), do: Repo.get!(Author, id)

  @doc """
  Creates a author.

  ## Examples

      iex> create_author(%{field: value})
      {:ok, %Author{}}

      iex> create_author(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_author(attrs \\ %{}) do
    %Author{}
    |> Author.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a author.

  ## Examples

      iex> update_author(author, %{field: new_value})
      {:ok, %Author{}}

      iex> update_author(author, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_author(%Author{} = author, attrs) do
    author
    |> Author.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Author.

  ## Examples

      iex> delete_author(author)
      {:ok, %Author{}}

      iex> delete_author(author)
      {:error, %Ecto.Changeset{}}

  """
  def delete_author(%Author{} = author) do
    Repo.delete(author)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking author changes.

  ## Examples

      iex> change_author(author)
      %Ecto.Changeset{source: %Author{}}

  """
  def change_author(%Author{} = author) do
    Author.changeset(author, %{})
  end


  @doc """
  Returns the list of stories.

  ## Examples

      iex> list_stories()
      [%Story{}, ...]

  """
  def list_stories do
    Repo.all(Story)
    |> Repo.preload([:url, :author])
  end

  @doc """
  Gets a single story.

  Raises `Ecto.NoResultsError` if the Story does not exist.

  ## Examples

      iex> get_story!(123)
      %Story{}

      iex> get_story!(456)
      ** (Ecto.NoResultsError)

  """
  def get_story!(id), do: Repo.get!(Story, id)

  
  @doc """
  Fetches and decodes top stories from the given address
  TODO: take in a url and fetch that instead of something hard coded
  Returns a list of stories
  """
  def fetch_stories do
    HTTPoison.start()
    r = HTTPoison.get!(Newzjunky.Config.url())
    body = Jason.decode!(r.body)

    body["articles"]
  end

  @doc """
  Insert a list of stories into the database
  """
  def insert_stories(stories) do
    stories
    |> Enum.each fn s ->
      Newzjunky.Stories.create_story(s)
      {:ok}
    end
  end

  @doc """
  Creates a story.

  ## Examples

      iex> create_story(%{field: value})
      {:ok, %Story{}}

      iex> create_story(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_story(attrs \\ %{}) do
    author = attrs["author"]
    url = attrs["url"]
    publishedAt = attrs["publishedAt"]
    dt =
      case publishedAt do
        nil -> 
          {:ok, dt} = DateTime.now("Etc/UTC")
            dt
        _ -> 
          {:ok, dt, _} = DateTime.from_iso8601(publishedAt)
          dt
      end

    story = %Story{
      title: attrs["title"],
      description: attrs["description"],
      content: attrs["content"],
      urlToImage: attrs["urlToImage"],
      publishedAt: dt
    }

    
    if url !== nil and url !== "" do
      url =
        # get or insert url
        case Repo.get_by(Url, address: url) || Repo.insert!(%Url{address: url})
        |> Ecto.build_assoc(:stories, story)
        |> Repo.insert() do
          {:ok, url} -> url
          url -> url
        end

      if author do
        # get or insert author
        Repo.get_by(Author, name: author) || Repo.insert!(%Author{name: author})
        |> Ecto.build_assoc(:stories, story)
        |> Repo.insert()
      end


      existing_story = Repo.one from story in Story,
        where: story.url_id == ^url.id
      

      # if the story already exists, we dont need to add it
      case existing_story do
        nil -> 
          story
            |> Repo.insert()
        {:ok, story} -> story
        story ->
          story
      end

    else
      Logger.info('Could not create story.')
      Logger.info('Unhandled URL Exception: #{inspect url}')
      {:error, 'Nil url'}
    end
  end

  @doc """
  Updates a story.

  ## Examples

      iex> update_story(story, %{field: new_value})
      {:ok, %Story{}}

      iex> update_story(story, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_story(%Story{} = story, attrs) do
    story
    |> Story.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Story.

  ## Examples

      iex> delete_story(story)
      {:ok, %Story{}}

      iex> delete_story(story)
      {:error, %Ecto.Changeset{}}

  """
  def delete_story(%Story{} = story) do
    Repo.delete(story)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking story changes.

  ## Examples

      iex> change_story(story)
      %Ecto.Changeset{source: %Story{}}

  """
  def change_story(%Story{} = story) do
    Story.changeset(story, %{})
  end

  alias Newzjunky.Stories.Url

  @doc """
  Returns the list of urls.

  ## Examples

      iex> list_urls()
      [%Url{}, ...]

  """
  def list_urls do
    Repo.all(Url)
  end

  @doc """
  Gets a single url.

  Raises `Ecto.NoResultsError` if the Url does not exist.

  ## Examples

      iex> get_url!(123)
      %Url{}

      iex> get_url!(456)
      ** (Ecto.NoResultsError)

  """
  def get_url!(id), do: Repo.get!(Url, id)

  @doc """
  Creates a url.

  ## Examples

      iex> create_url(%{field: value})
      {:ok, %Url{}}

      iex> create_url(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_url(attrs \\ %{}) do
    %Url{}
    |> Url.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a url.

  ## Examples

      iex> update_url(url, %{field: new_value})
      {:ok, %Url{}}

      iex> update_url(url, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_url(%Url{} = url, attrs) do
    url
    |> Url.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Url.

  ## Examples

      iex> delete_url(url)
      {:ok, %Url{}}

      iex> delete_url(url)
      {:error, %Ecto.Changeset{}}

  """
  def delete_url(%Url{} = url) do
    Repo.delete(url)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking url changes.

  ## Examples

      iex> change_url(url)
      %Ecto.Changeset{source: %Url{}}

  """
  def change_url(%Url{} = url) do
    Url.changeset(url, %{})
  end
end
