defmodule TestElixirToo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TestElixirTooWeb.Telemetry,
      # Start the Ecto repository
      TestElixirToo.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: TestElixirToo.PubSub},
      # Start Finch
      {Finch, name: TestElixirToo.Finch},
      # Start the Endpoint (http/https)
      TestElixirTooWeb.Endpoint
      # Start a worker by calling: TestElixirToo.Worker.start_link(arg)
      # {TestElixirToo.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TestElixirToo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TestElixirTooWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
