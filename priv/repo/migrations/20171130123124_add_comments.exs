defmodule Webpost.Repo.Migrations.AddComments do
  use Ecto.Migration

  def change do
  		alter table(:comments) do
  		add :is_active, :boolean, default: true
  		add :inserted_at, :utc_datetime, default: fragment("NOW()")
  	end
  end
end
