defmodule Smaug.Repo.Migrations.DeleteAuthorFromStories do
  use Ecto.Migration

  def change do
    alter table(:stories) do
      remove :author
    end
  end
end
