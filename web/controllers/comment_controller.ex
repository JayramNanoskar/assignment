defmodule Webpost.CommentController do
	use Webpost.Web, :controller

	alias Webpost.Post
	alias Webpost.Comment

	def new(conn, params) do
		IO.puts "$$$$$$$$$$   inside comment new  $$$$$$$$"
		IO.inspect params
		
 		struct= %Comment{}
 		params= %{}

 		changeset= Comment.changeset(struct, params)
		render(conn, "new.html", changeset: changeset)	

 	end
 	
 	def create(conn, params) do

 		IO.puts "+++++++++++++++++++++"
 		IO.inspect params
 		comment= params["comment"]["title"]
 		IO.puts "************"
 		IO.inspect comment
 				IO.puts "************"
 		changeset= Comment.changeset(%Comment{}, %{content: comment})
 		case Repo.insert(changeset) do
 			{:ok, comment}-> IO.puts "+++++++++++++++++++++"
 										IO.inspect(comment)
 										conn
 										|> put_flash(:info, "Comment Created")
 										|> redirect(to: post_path(conn,:show))						
 			{:error, changeset}-> 
 														IO.puts "---------------------"
 														IO.inspect(changeset)
 														render conn, "new.html", changeset: changeset
 		end
 	 
 	end

end
