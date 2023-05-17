defmodule ExunitSandboxDebugging.Repo.Migrations.AddPosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add(:name, :string, null: false)
    end
  end
end
