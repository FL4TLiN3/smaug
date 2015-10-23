defmodule Smaug.Repo.Migrations.AddOriginalLinkToStories do
  use Ecto.Migration

  def change do
    alter table(:stories) do
      add :original_link, :string
    end
  end
end
