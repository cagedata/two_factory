defmodule TwoFactorApp do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, TwoFactorApp.Router, [[], [port: Application.get_env(:two_factor_app, :port)]])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TwoFactorApp.Supervisor]
    IO.puts "Running on Port #{Application.get_env(:two_factor_app, :port)}"
    Supervisor.start_link(children, opts)
  end
end
