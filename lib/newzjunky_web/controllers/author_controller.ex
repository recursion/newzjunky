defmodule NewzjunkyWeb.AuthorController do
  use NewzjunkyWeb, :controller

  alias Newzjunky.Stories
  alias Newzjunky.Stories.Author

  action_fallback NewzjunkyWeb.FallbackController

  def index(conn, _params) do
    authors = Stories.list_authors()
    render(conn, "index.json", authors: authors)
  end

  def create(conn, %{"author" => author_params}) do
    with {:ok, %Author{} = author} <- Stories.create_author(author_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.author_path(conn, :show, author))
      |> render("show.json", author: author)
    end
  end

  def show(conn, %{"id" => id}) do
    author = Stories.get_author!(id)
    render(conn, "show.json", author: author)
  end

  def update(conn, %{"id" => id, "author" => author_params}) do
    author = Stories.get_author!(id)

    with {:ok, %Author{} = author} <- Stories.update_author(author, author_params) do
      render(conn, "show.json", author: author)
    end
  end

  def delete(conn, %{"id" => id}) do
    author = Stories.get_author!(id)

    with {:ok, %Author{}} <- Stories.delete_author(author) do
      send_resp(conn, :no_content, "")
    end
  end
end
