defmodule Newzjunky.Repo.Migrations.CreateStories do
  use Ecto.Migration

  def change do
    create table(:stories) do
      add :title, :string
      add :description, :text
      add :content, :text
      add :urlToImage, :string
      add :publishedAt, :utc_datetime
      add :url_id, references(:urls, on_delete: :nothing)
      add :author_id, references(:authors, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:stories, [:url_id])
    create index(:stories, [:author_id])
  end
end
