defmodule Newzjunky.Stories.Story do
  use Ecto.Schema
  import Ecto.Changeset
  alias Newzjunky.Stories.Author

  schema "stories" do
    field :content, :string
    field :description, :string
    field :publishedAt, :utc_datetime
    field :title, :string
    field :url, :string
    field :urlToImage, :string
    # field :author_id, :id
    belongs_to :author, Author

    timestamps()
  end

  @doc false
  def changeset(story, attrs) do
    story
    |> cast(attrs, [:title, :description, :content, :url, :urlToImage, :publishedAt])
    |> validate_required([:title, :description, :content, :url, :urlToImage, :publishedAt])
    |> unique_constraint(:url)
  end
end
