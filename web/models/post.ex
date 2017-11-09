defmodule Webpost.Post do 

	use Webpost.Web, :model

			schema "posts" do

				field :title, :string	

			end	


			def changeset(struct, params \\ %{}) do
				struct 
				|>cast(params, [:title])
				|>validate_required([:title])
			end

end	





	
