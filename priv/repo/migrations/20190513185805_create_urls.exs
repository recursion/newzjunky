defmodule Newzjunky.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :address, :string

      timestamps()
    end

    create unique_index(:urls, [:address])
  end
end
