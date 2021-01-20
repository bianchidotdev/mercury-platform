defmodule Wrangler.MixProject do
  use Mix.Project

  @test_envs [:test, :integration]

  def project do
    [
      app: :wrangler,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      # compilers: [:rustler] ++ Mix.compilers(),
      # rustler_crates: rustler_crates(),
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:csv, "~> 2.3"},
      # {:google_api_storage, "~> 0..0"},
      {:goth, "~> 1.2.0"},
      {:hackney, "~> 1.16.0"},
      {:jason, ">= 1.0.0"},
      {:ok, "~> 2.3"},
      {:tesla, "~> 1.3.0"},
      {:timber, "~> 3.0"},
      {:timber_exceptions, "~> 2.0"},
      {:vantagex, "~> 0.1"},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ex_machina, "~> 2.4", only: @test_envs}
      # {:rustler, "~> 0.21.0"},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  # defp rustler_crates do
  #   [
  #     parquetserializer: [path: "native/parquetserializer", mode: if(Mix.env() == :prod, do: :release, else: :debug)]
  #   ]
  # end

  defp elixirc_paths(env) when env in @test_envs, do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
