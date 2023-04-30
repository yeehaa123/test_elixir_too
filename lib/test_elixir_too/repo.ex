defmodule TestElixirToo.Repo do
  use Ecto.Repo,
    otp_app: :test_elixir_too,
    adapter: Ecto.Adapters.Postgres
end
