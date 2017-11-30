 	defmodule Webpost.Comment do
	
	use Webpost.Web, :model
	

	schema "comments" do
		
		field :content, :string
		field :is_active, :boolean
		belongs_to :post, Webpost.Post

	end

	def changeset(struct, params \\ %{}) do
		(struct) 
		|> cast(params, [:content])
		|> validate_required([:content])
	end
end