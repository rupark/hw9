defmodule PhotoBlogWeb.PostView do
  use PhotoBlogWeb, :view
  alias PhotoBlogWeb.PostView
  alias PhotoBlogWeb.UserView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    user = if Ecto.assoc_loaded?(post.user) do
      render_one(post.user, UserView, "user.json")
    else
      nil
    end

    %{
      id: post.id,
      body: post.body,
      title: post.title,
      date: post.date,
      user: user,
    }
  end
end
