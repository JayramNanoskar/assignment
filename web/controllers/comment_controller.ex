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
 	

 	def delete(conn, %{"comment" => comment, "id" => comment_id} ) do
 		IO.puts "@@@@@@@@@@@@@ inside delete comment  @@@@@@@@@@@@@@"
 	  Repo.get!(Comment, comment_id) |> Repo.delete!

 		conn
 		|> put_flash(:info, "Comment Deleted")
 		|> redirect(to: post_path(conn, :show))
 	end


 	def update(conn, %{"comment" => comment, "id" => comment_id, "post_id" => post_id}) do
 		IO.puts "=======================  inside comment update  ==========================="
 		IO.inspect comment
 		post= Repo.get!(Post, post_id)
 		old_comment= Repo.get(Comment, comment_id)
 		changeset= Comment.changeset(old_comment, comment)

 		case Repo.update(changeset) do
 			{:ok, _comment}->
 												conn
 												|> put_flash(:info, "Comment Updated")
 												|> redirect(to: post_path(conn, :show, post_id))
 			{:error, changeset}->
 												render conn, "edit.html", changeset: changeset, comment: old_comment, post: post
 		end	
 	end



 	def edit(conn, %{"id" => comment_id, "post_id" => post_id}) do
 		IO.puts "=======================  inside comment edit  ==========================="
 		IO.inspect comment_id
 		post= Repo.get(Post, post_id)
 		# IO.inspect post_id	
 		#comment= Repo.get(Comment, comment_id)
 	  comment= Repo.get(Ecto.assoc(post, :comments), comment_id)
 		changeset= Comment.changeset(comment)

 		render conn, "edit.html", changeset: changeset, comment: comment, post: post
 	end


 	def create(conn, params) do

 		IO.puts "=======================  inside 	comment create  ==========================="
 		IO.inspect params
 		comment= params["comment"]["title"]
 		IO.inspect comment
 		post_id= params["post_id"]
 		IO.inspect post_id
 		post= Repo.get!(Post, post_id)
 		IO.inspect post

 		changeset= Comment.changeset(Ecto.build_assoc(post, :comments, content: comment))
 		case Repo.insert(changeset) do
 			{:ok, comment}-> IO.puts "+++++++++++++++++++++"
 										IO.inspect(comment)
 										conn
 										|> put_flash(:info, "Comment Created")
 										|> redirect(to: post_path(conn, :show, post))						
 			{:error, changeset}-> 
 														IO.puts "---------------------"
 														IO.puts "---------------------"
 														IO.puts "---------------------"
 														IO.puts "---------------------"
 														IO.puts "---------------------"
 														IO.inspect(changeset)
 														conn
 														|> put_flash(:info, "Comment can not be blank")
 														|> redirect(to: post_path(conn, :show, post))
 														# render conn, "new.html", changeset: changeset, post: post
 		end
 	 
 	end

end
