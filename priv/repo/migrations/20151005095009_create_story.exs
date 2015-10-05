defmodule Smaug.Repo.Migrations.CreateStory do
  use Ecto.Migration

  def change do
    create table(:stories) do
      add :title, :string
      add :author, :string
      add :cover, :string
      add :published_at, :datetime
      add :description, :text

      timestamps
    end

  end
end
