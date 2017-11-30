defmodule Webpost.Repo.Migrations.AddComments do
  use Ecto.Migration

  def change do
  		alter table(:comments) do
  		
  		remove :is_active
  		remove :inserted_at
  		remove :updated_at
  end
end

end

