defmodule TwoFactorApp do
  use Application

  @defaults %{port: 4000}

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, TwoFactorApp.Router, [], [port: port()])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TwoFactorApp.Supervisor]
    IO.puts "Running on Port #{port()}"
    Supervisor.start_link(children, opts)
  end

  defp port, do: port(Application.get_env(:two_factor_app, :port))
  defp port({:system, var}), do: var |> System.get_env |> Integer.parse |> elem(0)
  defp port(p) when is_integer(p), do: p
  defp port(_), do: @defaults.port
end
