defmodule PhotoBlogWeb.InviteController do
  use PhotoBlogWeb, :controller
  # import PhotoBlogWeb.Helpers

  alias PhotoBlog.Invites
  alias PhotoBlog.Invites.Invite
  alias PhotoBlog.Users
  alias PhotoBlog.Users.User

  def index(conn, _params) do
    invites = Invites.list_invites()
    render(conn, "index.html", invites: invites)
  end

  def new(conn, _params) do
    changeset = Invites.change_invite(%Invite{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"invite" => invite_params}) do
    IO.inspect(invite_params)
    invite_params = invite_params
    |> Map.put("user_id", Users.get_user_by_email(invite_params["email"]))
    |> Map.put("status", "No Response")
    case Invites.create_invite(invite_params) do
      {:ok, invite} ->
        conn
        |> put_flash(:info, "Invite created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, invite.post_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    invite = Invites.get_invite!(id)
    render(conn, "show.html", invite: invite)
  end

  def edit(conn, %{"id" => id}) do
    invite = Invites.get_invite!(id)
    changeset = Invites.change_invite(invite)
    render(conn, "edit.html", invite: invite, changeset: changeset)
  end

  def update(conn, %{"id" => id, "invite" => invite_params}) do
    invite = Invites.get_invite!(id)

    case Invites.update_invite(invite, invite_params) do
      {:ok, invite} ->
        conn
        |> put_flash(:info, "Invite updated successfully.")
        |> redirect(to: Routes.invite_path(conn, :show, invite))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", invite: invite, changeset: changeset)
    end
  end

  # def accept(conn, %{"id" => id, "invite" => invite_params}) do
  #   invite = Invites.get_invite!(id)
  #
  #   case Invites.update_invite(invite, invite_params) do
  #     {:ok, invite} ->
  #       conn
  #       |> put_flash(:info, "Invite updated successfully.")
  #       |> redirect(to: Routes.invite_path(conn, :show, invite))
  #
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", invite: invite, changeset: changeset)
  #   end
  # end
  #
  # def accept(conn, %{"id" => id, "invite" => invite_params}) do
  #   invite = Invites.get_invite!(id)
  #   invite_params = invite_params
  #   |> Map.put("status", "Accept")
  #
  #   case Invites.update_invite(invite, invite_params) do
  #     {:ok, invite} ->
  #       conn
  #       |> put_flash(:info, "Invite updated successfully.")
  #       |> redirect(to: Routes.invite_path(conn, :show, invite))
  #
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", invite: invite, changeset: changeset)
  #   end
  # end
  #
  # def maybe(conn, %{"id" => id, "invite" => invite_params}) do
  #   invite = Invites.get_invite!(id)
  #   invite_params = invite_params
  #   |> Map.put("status", "Accept")
  #
  #   case Invites.update_invite(invite, invite_params) do
  #     {:ok, invite} ->
  #       conn
  #       |> put_flash(:info, "Invite updated successfully.")
  #       |> redirect(to: Routes.invite_path(conn, :show, invite))
  #
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", invite: invite, changeset: changeset)
  #   end
  # end

  def delete(conn, %{"id" => id}) do
    invite = Invites.get_invite!(id)
    {:ok, _invite} = Invites.delete_invite(invite)

    conn
    |> put_flash(:info, "Invite deleted successfully.")
    |> redirect(to: Routes.invite_path(conn, :index))
  end
end
