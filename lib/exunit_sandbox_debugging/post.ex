defmodule ExunitSandboxDebugging.Post do
  use Ecto.Schema

  schema "posts" do
    field(:name, :string)
  end
end
