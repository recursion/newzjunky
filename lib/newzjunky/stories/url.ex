defmodule Newzjunky.Stories.Url do
  use Ecto.Schema
  import Ecto.Changeset
  alias Newzjunky.Stories.Story

  schema "urls" do
    field :address, :string
    has_many :stories, Story

    timestamps()
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:address])
    |> validate_required([:address])
  end
end
