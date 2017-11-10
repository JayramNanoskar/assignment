defmodule Webpost.Repo.Migrations.AddComments do
  use Ecto.Migration

  def change do

  		create table(:comments) do
  			
  			add :content, :string
  			add :post_id, references(:posts)
  			
  		end
  end
end
