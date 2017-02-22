defmodule Discuss.Topic do
  use Discuss.Web, :model

  schema "topics" do
    field :title, :string
    timestamps()
    # field :inserted_at, :utc_datetime, default: Ecto.DateTime.from_erl(:erlang.localtime)
    # field :updated_at, :utc_datetime, default: Ecto.DateTime.from_erl(:erlang.localtime)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
