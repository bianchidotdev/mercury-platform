defmodule Wrangler.MixProject do
  use Mix.Project

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
      # {:google_api_storage, "~> 0.20"},
      {:goth, "~> 1.2.0"},
      {:tesla, "~> 1.3.0"},
      {:vantagex, "~> 0.1"},
      {:ex_machina, "~> 2.4", only: :test}
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

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
