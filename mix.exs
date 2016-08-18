defmodule TwoFactorApp.Mixfile do
  use Mix.Project

  def project do
    [app: :two_factor_app,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :cowboy, :plug, :httpotion, :poison],
     mod: {TwoFactorApp, []}]
  end

  defp deps do
    [{:plug, "~> 1.2.0"},
     {:cowboy, "~> 1.0.4"},
     {:httpotion, "~> 3.0.0"},
     {:poison, "~> 2.2.0"}]
  end
end
