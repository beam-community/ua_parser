defmodule Example.Repo.Migrations.CreateFoo do
  use Ecto.Migration

  def change do
    create table(:foos) do
      add :bar, :string

      timestamps()
    end

  end
end
