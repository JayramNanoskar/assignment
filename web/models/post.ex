defmodule Webpost.Post do 

	use Webpost.Web, :model


			schema "posts" do

				field :title, :string	
				field :is_active, :boolean
				has_many :comments, Webpost.Comment
			end	


			def changeset(struct, params \\ %{}) do
				(struct) 
				|> cast(params, [:title, :is_active])
				|> validate_required([:title])
			end
			
end	





	
