defmodule Discuss.PageControllerTest do
  use Discuss.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
#
# defmodule HelloPhoenix.UserControllerTest do
#   use HelloPhoenix.ConnCase, async: true
#
#   alias HelloPhoenix.{Repo, User}
#
#   test "index/2 responds with all Users" do
#     users = [ User.changeset(%User{}, %{name: "John", email: "john@example.com"}),
#               User.changeset(%User{}, %{name: "Jane", email: "jane@example.com"}) ]
#
#     Enum.each(users, &Repo.insert!(&1))
#
#     response = build_conn
#     |> get(user_path(build_conn, :index))
#     |> json_response(200)
#
#     expected = %{
#       "data" => [
#         %{ "name" => "John", "email" => "john@example.com" },
#         %{ "name" => "Jane", "email" => "jane@example.com" }
#       ]
#     }
#
#     assert response == expected
#   end
