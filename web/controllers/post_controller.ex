defmodule Webpost.PostController do
	use Webpost.Web, :controller

	alias Webpost.Post
	alias Webpost.Comment

	def index(conn, _params) do
    query= from(p in Post, order_by: p.title)
    posts= 	Repo.all(query)

    posts = for post <- posts do
      # IO.inspect post
      # IO.puts "======================  ************            ==========================="
      %Webpost.Post{id: post_id}= post
      total_comm=Repo.one(from p in Post, join: c in Comment, on: c.post_id == p.id, 
      where: p.id== ^post_id, select: count(c.id))
      # IO.inspect total_comm
      c = %{count: total_comm}
      Map.merge(post, c)
    end

    total_post= Repo.one(from(p in Post, select: count(p.id)))
    # IO.inspect total_post, charlists: :as_lists
    # IO.puts "======================              ==========================="
    # IO.inspect posts
    # IO.puts "======================              ==========================="
    render conn, "index.html", posts: posts, total: total_post
  end




  def is_active(conn, %{"id"=> post_id, "is_active" => status}) do
    # IO.inspect status
    new_status= %{"is_active" => status}
    post=Repo.get(Post, post_id)
    changeset=Post.changeset(post, new_status)
    if(status=="true") do
      Repo.update(changeset)
      conn
      |> put_flash(:info, "Post Activated")
      |> redirect(to: post_path(conn, :index))
    else
      Repo.update(changeset)
      conn
      |> put_flash(:info, "Post Deactivated")
      |> redirect(to: post_path(conn, :index))
    end
    #render(conn, "index.html",changeset: changeset, post: post)
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
 			{:ok, post}-> 
                    # IO.inspect(post)
 										conn
 										|> put_flash(:info, "Post Created")
 										|> redirect(to: post_path(conn,:index))						
 			{:error, changeset}-> 
                    # IO.inspect(changeset)
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
		# IO.inspect params q
		#title= params[:post][:title]	
    # IO.inspect post
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



  def show(conn, params) do
    %{"id" => post_id}=params
    post= Repo.get!(Post, post_id)
    c= post |> Repo.preload([comments: (from c in Comment, order_by: c.inserted_at)])
    # IO.inspect c
    comments= c.comments
    status= c.is_active
    struct= %Comment{}
    params= %{}
    changeset= Comment.changeset(struct, params)

    query= from p in Post, join: c in Comment, on: c.post_id == p.id, 
    where: p.id == ^post_id, select: count(c.id)
    total_comments= Repo.one(query)
    
    # IO.puts "#################____________________________##############"
    # IO.inspect comments 
    # IO.puts "#################___________________________###############"
    # changeset= Repo.all(Ecto.assoc(post, :comments))
    # changeset= Post.changeset(post)
    render(conn, "show.html", post: post,  changeset: changeset, comments: comments,
    total_comments: total_comments, comment_status: status)
  end

  
end