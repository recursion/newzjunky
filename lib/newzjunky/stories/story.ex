defmodule Newzjunky.Stories.Story do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stories" do
    field :author, :string
    field :content, :string
    field :description, :string
    field :publishedAt, :utc_datetime
    field :title, :string
    field :url, :string
    field :urlToImage, :string

    timestamps()
  end

  @doc false
  def changeset(story, attrs) do
    story
    |> cast(attrs, [
      :title,
      :description,
      :content,
      :url,
      :urlToImage,
      :publishedAt,
      :author
    ])
    |> validate_required([
      :url
    ])
    |> unique_constraint(:url)
  end
end
