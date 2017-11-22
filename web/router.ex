defmodule Webpost.Router do
  use Webpost.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Webpost do
    pipe_through :browser # Use the default browser stack

    get "/", PostController, :index
    # get "/posts/new", PostController, :new
    # post "/posts", PostController, :create
    # get "/posts/:id/edit", PostController, :edit
    # put "/posts/:id", PostController, :update
    get "/posts/:id/isactive", PostController, :is_active
    
    
    #resources "/posts", PostController 
    resources "/posts", PostController do 
        resources "/comments", CommentController
    end
    #resources "/comments", CommentController
    # get "/comments/new", CommentController, :new
    # post "/comments", CommentController, :create
    
    
   # resources "/status", CommentController, :isActive
    
  end

  # Other scopes may use custom stacks.
  # scope "/api", Webpost do
  #   pipe_through :api
  # end
end
