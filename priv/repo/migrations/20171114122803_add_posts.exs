defmodule Webpost.Repo.Migrations.AddPosts do
  use Ecto.Migration

  def change do

  	alter table(:posts) do
  		
  		add :isActive, :string

  	end

  end
  
end
