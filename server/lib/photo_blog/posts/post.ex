defmodule PhotoBlog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :date, :string
    field :title, :string
    belongs_to :user, PhotoBlog.Users.User
    has_many :comments, PhotoBlog.Comments.Comment
    has_many :invites, PhotoBlog.Invites.Invite

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :date, :body, :user_id])
    |> validate_required([:title, :date, :body, :user_id])
  end
end
