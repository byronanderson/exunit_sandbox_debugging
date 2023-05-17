defmodule ExunitSandboxDebugging.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ExunitSandboxDebuggingWeb.Telemetry,
      # Start the Ecto repository
      ExunitSandboxDebugging.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ExunitSandboxDebugging.PubSub},
      # Start the Endpoint (http/https)
      ExunitSandboxDebuggingWeb.Endpoint
      # Start a worker by calling: ExunitSandboxDebugging.Worker.start_link(arg)
      # {ExunitSandboxDebugging.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExunitSandboxDebugging.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExunitSandboxDebuggingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
