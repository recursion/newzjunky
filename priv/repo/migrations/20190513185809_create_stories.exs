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
      add :author_id, references(:authors, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:stories, [:url])
    create index(:stories, [:author_id])
  end
end
