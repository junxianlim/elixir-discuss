defmodule Discuss.TopicControllerTest do
  use Discuss.ConnCase
  alias Discuss.{Repo, Topic}

  describe "topics Index" do
    test "gets list of topics" do

      for _ <- 1..10 do
        insert(:topic)
      end

      response = build_conn()
      |> get(topic_path(build_conn(), :index))

      topics = response.assigns.topics

      assert Enum.count(topics) == 10
    end
  end

  describe "topics show" do
    test "fetchs topic of correct id" do
      topic = insert(:topic)

      response = build_conn()
      |> get(topic_path(build_conn(), :show, topic.id))

      topic_response = response.assigns.topic

      assert topic_response == topic
    end
  end

  describe "topics new" do
    test "creates a new topic struct" do

      sample_changeset = Topic.changeset(%Topic{}, %{})

      response = build_conn()
      |> get(topic_path(build_conn(), :new))

      topic_changeset = response.assigns.changeset

      assert topic_changeset == sample_changeset
    end
  end

  describe "topics create" do
    test "creates a new topic" do

      post(build_conn(), topic_path(build_conn(), :create, topic: %{ title: "new title" }))

      topic = Repo.get_by(Topic, title: "new title")
      topics = Repo.all(Topic)

      assert Enum.count(topics) == 1
      assert topic.title == "new title"
    end
  end

  describe "topics edit" do
    test "edits existing topic" do
      topic = insert(:topic)
      changeset = Topic.changeset(topic)

      response = build_conn()
      |> get(topic_path(build_conn(), :edit, topic.id))

      topic_response = response.assigns.topic
      changeset_response = response.assigns.changeset

      assert topic_response == topic
      assert changeset_response == changeset
    end
  end

  describe "topics update" do
    test "updates existing topic" do
      existing_topic = insert(:topic)

      put(build_conn(), topic_path(build_conn(), :update, existing_topic.id, topic: %{ title: "updated title"}))

      updated_topic = Repo.get(Topic, existing_topic.id)

      assert updated_topic.title == "updated title"
    end
  end

  describe "topics delete" do
    test "deletes existing topic" do
      topic = insert(:topic)

      delete(build_conn(), topic_path(build_conn(), :delete, topic.id))

      topics = Repo.all(Topic)
      
      assert Enum.count(topics) == 0
    end
  end
end
