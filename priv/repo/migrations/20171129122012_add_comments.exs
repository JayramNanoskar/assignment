defmodule Webpost.Repo.Migrations.AddComments do
  use Ecto.Migration

  def change do
  	
  	alter table(:comments) do
  		
  		remove :created_at
  		
  	end
  end

end