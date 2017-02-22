defmodule Discuss.TopicController do
  use Discuss.Web, :controller
  alias Discuss.{Repo, Topic}

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render conn, "index.html", topics: topics
  end

  def show(conn, %{ "id" => id }) do
    case Repo.get(Topic, id) do
      topic when is_map(topic) ->
        conn
        |> render("show.html", topic: topic)
      _ ->
        handle_nil_topic(conn)
    end
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"topic" => topic_params}) do
    changeset = Topic.changeset(%Topic{}, topic_params)
    case Repo.insert(changeset) do
      {:ok, topic} ->
        conn
        |> redirect(to: topic_path(conn, :show, topic.id))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "error")
        |> render("new.html", changeset: changeset)
    end
  end

  def edit(conn, %{ "id" => id }) do
    case Repo.get(Topic, id) do
      topic when is_map(topic) ->
        changeset = Topic.changeset(topic)
        render conn, "edit.html", changeset: changeset, topic: topic
      nil ->
        handle_nil_topic(conn)
    end
  end

  def update(conn, %{ "id" => id, "topic" => topic_params }) do
    case Repo.get(Topic, id) do
      topic when is_map(topic) ->
        topic = Topic.changeset(topic, topic_params)
        case Repo.update(topic) do
          {:ok, topic} ->
            conn
            |> put_flash(:info, "topic updated")
            |> redirect(to: topic_path(conn, :show, topic.id))
          {:error, changeset} ->
            conn
            |> put_flash(:error, "error")
            |> render("edit.html", changeset: changeset)
        end
      nil ->
        handle_nil_topic(conn)
    end
  end

  def delete(conn, %{ "id" => id}) do
    case Repo.get(Topic, id) do
      topic when is_map(topic) ->
        case Repo.delete(topic) do
          {:ok, topic} ->
            conn
            |> put_flash(:info, "Topic: #{topic.title} deleted")
            |> redirect(to: topic_path(conn, :index))
          {:error, _changeset} ->
            conn
            |> put_flash(:error, "Error deleting")
            |> render("index.html")
        end
      nil ->
        handle_nil_topic(conn)
    end
  end

  # Private

  defp handle_nil_topic(conn) do
    conn
    |> put_flash(:error, "No such topic")
    |> redirect(to: topic_path(conn, :index))
  end
end
