defmodule ExImageInfo.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_image_info,
      description:
        "ExImageInfo is an Elixir library to parse images (binaries) and get the dimensions (size), detected mime-type and overall validity for a set of image formats. It is the fastest and supports multiple formats.",
      version: "VERSION" |> File.read!() |> String.trim(),
      elixir: "~> 1.3",
      name: "ExImageInfo",
      package: package(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      docs: docs(),
      source_url: "https://github.com/Group4Layers/ex_image_info",
      homepage_url: "https://www.group4layers.com",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:excoveralls, "~> 0.18", only: :test},
      {:ex_doc, "~> 0.30", only: :dev},
      {:inch_ex, "~> 2.0", only: [:dev, :test]},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:styler, "~> 1.3", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases do
    [
      test_wip: ["test --only wip"],
      lint: [
        "format --check-formatted",
        "deps.unlock --check-unused",
        "credo --all --strict"
      ]
    ]
  end

  defp docs do
    [
      extras: ["README.md", "LICENSE.md", "CHANGELOG.md", "CONTRIBUTORS.md"],
      assets: %{"assets/" => "assets"}
    ]
  end

  defp package do
    [
      name: :ex_image_info,
      # just the minimum for prod
      files: [
        "lib",
        "README.md",
        "VERSION",
        "LICENSE.md",
        "mix.exs"
      ],
      maintainers: ["nozalr <nozalr@group4layers.com>"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/Group4Layers/ex_image_info",
        "Organization" => "https://www.group4layers.com"
      }
    ]
  end
end
