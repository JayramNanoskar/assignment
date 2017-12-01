defmodule Webpost.PageController do
	use Webpost.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
