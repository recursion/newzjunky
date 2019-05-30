defmodule Newzjunky.Stories.Story do
  use Ecto.Schema
  import Ecto.Changeset
  alias Newzjunky.Stories.{Author, Url}

  schema "stories" do
    field :content, :string
    field :description, :string
    field :publishedAt, :utc_datetime
    field :title, :string
    field :urlToImage, :string
    # field :author_id, :id
    #field :url, :string
    belongs_to :author, Author
    belongs_to :url, Url

    timestamps()
  end

  @doc false
  def changeset(story, attrs) do
    story
    |> cast(attrs, [:title, :description, :content, :urlToImage, :publishedAt])
    |> validate_required([:title, :description, :content, :urlToImage, :publishedAt])
  end
end
