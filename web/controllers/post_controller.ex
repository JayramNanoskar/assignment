defmodule Webpost.PostController do
	use Webpost.Web, :controller

	alias Webpost.Post
	alias Webpost.Comment

	

	def index(conn, _params) do
    posts= 	Repo.all(Post)
    render conn, "index.html", posts: posts
  end


  def show(conn, %{"id" => post_id}) do

  	post= Repo.get!(Post, post_id)
  	c= post |> Repo.preload(:comments)
  	comments= c.comments
  	# IO.puts "******post******"

  	# IO.inspect post

  	# IO.puts "******comments******"

  	# IO.inspect comments
  	
  	changeset= Post.changeset(post)
  	render(conn, "show.html", post: post, changeset: changeset, comments: comments)
  end


 	def new(conn, _params) do

 		struct= %Post{}
 		params= %{}

 		changeset= Post.changeset(struct, params)
		render(conn, "new.html", changeset: changeset)	

 	end


 	def create(conn, params) do
 		title= params["post"]["title"]

 		changeset= Post.changeset(%Post{}, %{title: title})
 		case Repo.insert(changeset) do
 			{:ok, post}-> IO.inspect(post)
 										conn
 										|> put_flash(:info, "Post Created")
 										|> redirect(to: post_path(conn,:index))						
 			{:error, changeset}-> IO.inspect(changeset)
 														render conn, "new.html", changeset: changeset
 		end
 	 
 	end


 	def edit(conn, %{"id" => post_id}) do
 		post= Repo.get(Post, post_id)
 		#IO.inspect post
 		changeset=Post.changeset(post)

 		render conn, "edit.html", changeset: changeset, post: post
 	end


 	def update(conn, %{"id"=> post_id, "post"=> post}) do
		# IO.inspect params 
		#title= params[:post][:title]	
		old_post= Repo.get(Post, post_id)
		changeset= Post.changeset(old_post, post)
		#IO.inspect changeset
		case Repo.update(changeset) do
			{:ok, _post}->
				conn
				|> put_flash(:info, "Post Updated")
				|> redirect(to: post_path(conn, :index))
			{:error, changeset}->
				render conn, "edit.html", changeset: changeset, post: old_post
		end

 	end


 	def delete(conn, %{"id" => post_id}) do
 		Repo.get!(Post, post_id) |> Repo.delete!

 		conn
 		|> put_flash(:info, "Topic Deleted")
 		|> redirect(to: post_path(conn, :index))
 	end


  # def add_comment(conn, %{"comment" => comment_params, "post_id" => post_id}) do
  #   changeset = Comment.changeset(%Comment{}, Map.put(comment_params, "post_id", post_id))
  #   post = Repo.get(Post, post_id) |> Repo.preload([:comments])

  #   if changeset.valid? do
  #     Repo.insert(changeset)

  #     conn
  #     |> put_flash(:info, "Comment added.")
  #     |> redirect(to: post_path(conn, :show, post))
  #   else
  #     render(conn, "show.html", post: post, changeset: changeset)
  #   end
  end

  
end