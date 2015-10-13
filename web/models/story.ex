defmodule Smaug.Story do
  use Smaug.Web, :model

  schema "stories" do
    field :title, :string
    field :author, :string
    field :cover, :string
    field :published_at, Ecto.DateTime
    field :description, :string

    belongs_to :category, Smaug.Category
    timestamps
  end

  @required_fields ~w(title author cover published_at description category_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
