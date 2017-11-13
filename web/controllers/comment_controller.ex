defmodule Webpost.CommentController do
	use Webpost.Web, :controller

	alias Webpost.Comment
	alias Webpost.Post

	def new(conn, _params) do
		struct= %Comment{}
		params= %{}
		changeset= Comment.changeset(struct, params)
		IO.puts "++++++	++++   inside new Comment   ++++++++++++"
		IO.inspect params
		
		render conn, "show.html", changeset: changeset
	end


 	def create(conn, params) do
 		IO.puts "++++++	++++   inside create Comment   ++++++++++++"
		IO.inspect params

 		title= params["comment"]["title"]

 		changeset= Comment.changeset(%Comment{}, %{title: title})
 		case Repo.insert(changeset) do
 			{:ok, post}-> IO.inspect(post)
 										conn
 										|> put_flash(:info, "Comment Created")
 										|> redirect(to: post_path(conn,:index))						
 			{:error, changeset}-> IO.inspect(changeset)
 														render conn, "new.html", changeset: changeset
 		end
 	 
 	end


end