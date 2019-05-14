defmodule Newzjunky.Stories.Author do
  use Ecto.Schema
  import Ecto.Changeset
  alias Newzjunky.Stories.Story

  schema "authors" do
    field :name, :string
    has_many :stories, Story

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
