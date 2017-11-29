defmodule Webpost.Repo.Migrations.AddComments do
  use Ecto.Migration

  def change do
  	
  	alter table(:comments) do
  		
  		add :created_at, :timestamp, default: date()
  		timestamps()
  	end
  end

end
