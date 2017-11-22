defmodule Webpost.CommentController do
	use Webpost.Web, :controller

	alias Webpost.Post
	alias Webpost.Comment


	def new(conn, %{"post_id" => post_id}) do
		IO.puts "=======================  inside comment new  ==========================="
		post= Repo.get!(Post, post_id)
		IO.inspect post
 		struct= %Comment{}
 		params= %{}
 		changeset= Comment.changeset(struct, params)
		render(conn, "show.html", changeset: changeset, post: post)	

 	end
 	
 	def edit(conn, %{"id" => comment_id, "post_id" => post_id}) do
 		IO.puts "=======================  inside comment edit  ==========================="
 		IO.inspect comment_id
 		post= Repo.get(Post, post_id)
 		IO.puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
 		IO.inspect post_id	
 		render conn. "edit.html", post_id: post_id, comment_id: comment_id
 	end

 	def create(conn, params) do

 		IO.puts "=======================  inside comment create  ==========================="
 		IO.inspect params
 		comment= params["comment"]["title"]
 		IO.inspect comment
 		post_id= params["post_id"]
 		IO.inspect post_id
 		post= Repo.get!(Post, post_id)
 		IO.inspect post

 		changeset= Ecto.build_assoc(post, :comments, content: comment)
 		case Repo.insert(changeset) do
 			{:ok, comment}-> IO.puts "+++++++++++++++++++++"
 										IO.inspect(comment)
 										conn
 										|> put_flash(:info, "Comment Created")
 										|> redirect(to: post_comment_path(conn, :new, post))						
 			{:error, changeset}-> 
 														IO.puts "---------------------"
 														IO.inspect(changeset)
 														render conn, "new.html", changeset: changeset
 		end
 	 
 	end

end
