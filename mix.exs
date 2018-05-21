defmodule PhoenixPostman.Mixfile do
  use Mix.Project

  @test_envs [:dev, :test]

  def project do
    [
      app: :phoenix_postman,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      test_coverage: [tool: ExCoveralls],
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  if (Mix.env() in @test_envs) do
    def application do
      [
        mod: {PhoenixPostman.Application, []},
        extra_applications: [:logger, :runtime_tools]
      ]
    end
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(env) when env in @test_envs, do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:excoveralls, "~> 0.8.2", only: @test_envs},
      {:phoenix, "~> 1.3.2", only: @test_envs},
      {:cowboy, "~> 1.0", only: @test_envs},
      {:plug, "~> 1.5.1"}
    ]
  end
end
