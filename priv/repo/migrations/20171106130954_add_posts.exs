defmodule Webpost.Repo.Migrations.AddPosts do
  use Ecto.Migration

  def change do

  	create table(:posts) do
  		
  		add :title, :string
  		
  	end
  end
end
