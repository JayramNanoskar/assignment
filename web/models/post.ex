defmodule Webpost.Post do 

	use Webpost.Web, :model


			schema "posts" do

				field :title, :string	
				field :isActive, :string
				has_many :comments, Webpost.Comment
			end	


			def changeset(struct, params \\ %{}) do
				(struct) 
				|> (cast(params, [:title]))
				|> (validate_required([:title] , [:isActive]))
			end
			
end	





	
