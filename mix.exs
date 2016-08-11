defmodule ExImageInfo.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_image_info,
      description: "ExImageInfo is an Elixir library to parse images (binaries) and get the dimensions, detected mime-type and overall validity for a set of image formats.",
      version: "0.1.0",
      elixir: "~> 1.3",
      name: 'ExImageInfo',
      package: package,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      aliases: aliases,
      deps: deps(),
      docs: docs(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.html": :test],
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:excoveralls, "~> 0.5", only: :test},
      {:ex_doc, "~> 0.12", only: :dev},
      {:inch_ex, "~> 0.5", only: [:dev, :test]},
    ]
  end

  defp aliases do
    [
      "test_wip": ["test --only wip"]
    ]
  end

  defp docs do
    [
      extras: ["README.md", "LICENSE.md", "CHANGELOG.md", "CONTRIBUTORS.md"]
    ]
  end

  defp package do
    [
      name: :ex_image_info,
      # just the minimum for prod
      files: [
        "lib",
        "README.md",
        "LICENSE.md",
        "mix.exs",
      ],
      maintainers: ["rNoz <rnoz.commits@gmail.com>"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/rNoz/ex_image_info",
        "Docs" => "https://rnoz.github.io/ex_image_info",
      }
    ]
  end
end
