defmodule PointTuza.Mixfile do
  use Mix.Project

  def project do
    [app: :point_tuza,
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
    [
      mod: {PointTuza, []},
      applications: [:logger, :gproc, :cowboy, :plug, :ecto, :postgrex]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:poison, "~> 3.0"},
      {:gproc, "~> 0.6.1"},
      {:cowboy, "~> 1.0"},
      {:plug, "~> 1.3"},
      {:ecto, "~> 2.1"},
      {:postgrex, "~> 0.13.0"},
      {:credo, "~> 0.5", only: [:dev, :test]}
    ]
  end
end
