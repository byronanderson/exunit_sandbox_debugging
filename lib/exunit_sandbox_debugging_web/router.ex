defmodule ExunitSandboxDebuggingWeb.Router do
  use ExunitSandboxDebuggingWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExunitSandboxDebuggingWeb do
    pipe_through :api
  end
end
