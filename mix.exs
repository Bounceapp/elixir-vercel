defmodule Vercel.MixProject do
  use Mix.Project

  def project do
    [
      app: :vercel,
      version: "0.1.2",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description: "An elixir wrapper for Vercel's API",
      package: package(),
      deps: deps(),
      # Docs
      name: "Vercel",
      source_url: "https://github.com/Bounceapp/elixir-vercel",
      homepage_url: "https://github.com/Bounceapp/elixir-vercel",
      docs: [
        # The main page in the docs
        main: "Vercel",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:poison, "~> 4.0"},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false}
    ]
  end

  defp package() do
    [
      files: ~w(lib .formatter.exs mix.exs README* LICENSE*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/Bounceapp/elixir-vercel"}
    ]
  end
end
