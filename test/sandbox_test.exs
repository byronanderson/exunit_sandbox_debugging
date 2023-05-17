defmodule ExunitSandboxDebugging.SandboxTest do
  alias ExunitSandboxDebugging.Repo
  alias ExunitSandboxDebugging.Post
  use ExUnit.Case

  test "reproduce the issue" do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    test_pid = self()

    attach_sandbox = fn ->
      Ecto.Adapters.SQL.Sandbox.allow(Repo, test_pid, self())
    end

    assert [] = Repo.all(Post)
    pid = start_supervised!({Collaborator, setup: attach_sandbox})
    assert [] = GenServer.call(pid, :get_posts)
  end
end

defmodule Collaborator do
  use GenServer
  alias ExunitSandboxDebugging.Repo
  alias ExunitSandboxDebugging.Post

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(args) do
    args[:setup].()
    Process.flag(:trap_exit, true)

    {:ok, nil}
  end

  def handle_call(:get_posts, _, state) do
    {:reply, Repo.all(Post), state}
  end

  def terminate(_, _) do
    IO.inspect(:terminate)

    [] = Repo.all(Post)
  end
end
