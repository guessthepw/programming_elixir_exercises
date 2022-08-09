defmodule Issues.MixProject do
  use Mix.Project

  def project do
    [
      app: :issues,
      escript: escript_config(),
      version: "0.1.0",
      name: "Github CLI tool",
      elixir: "~> 1.6-dev",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.8.0"},
      {:poison, "~> 5.0"},
      {:ex_doc,  "~> 0.19.0"},
      {:earmark, "~> 1.2.4"}
    ]
  end

  defp escript_config do
    [
      main_module: Issues.CLI
    ]
  end
end
