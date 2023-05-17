defmodule ExunitSandboxDebugging.Repo do
  use Ecto.Repo,
    otp_app: :exunit_sandbox_debugging,
    adapter: Ecto.Adapters.Postgres
end
