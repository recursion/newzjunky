defmodule Newzjunky.Repo.Migrations.CreateStories do
  use Ecto.Migration

  def change do
    create table(:stories) do
      add :title, :string
      add :description, :text
      add :content, :text
      add :url, :string
      add :urlToImage, :string
      add :publishedAt, :utc_datetime
      add :author, :string
      add :source, :string

      timestamps()
    end

    create unique_index(:stories, [:url])
  end
end
