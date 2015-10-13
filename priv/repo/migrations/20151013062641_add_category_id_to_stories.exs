defmodule Smaug.Repo.Migrations.AddCategoryIdToStories do
  use Ecto.Migration

  def change do
    alter table(:stories) do
      add :category_id, :integer
    end
  end
end
