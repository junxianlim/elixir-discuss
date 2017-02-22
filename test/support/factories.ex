defmodule Discuss.Factory do
  alias Discuss.{Repo, Topic}
  use ExMachina.Ecto, repo: Repo

  def topic_factory do
    %Topic{
      title: sequence(:title, &"topic #{&1}")
    }
  end

  # Examples
  # def user_factory do
  #   %MyApp.User{
  #     name: "Jane Smith",
  #     email: sequence(:email, &"email-#{&1}@example.com"),
  #   }
  # end
  #
  # def article_factory do
  #   %MyApp.Article{
  #     title: "Use ExMachina!",
  #     # associations are inserted when you call `insert`
  #     author: build(:user),
  #   }
  # end
  #
  # def comment_factory do
  #   %MyApp.Comment{
  #     text: "It's great!",
  #     article: build(:article),
  #   }
  # end
end
