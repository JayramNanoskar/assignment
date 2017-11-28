defmodule Webpost.Repo.Migrations.AddPosts do
  use Ecto.Migration

  def change do

  	alter table(:posts) do
  		
  		add :is_active, :boolean, default: true
  		
  	end

  end
  
end
