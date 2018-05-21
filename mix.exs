defmodule ExImageInfo.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_image_info,
      description: "ExImageInfo is an Elixir library to parse images (binaries) and get the dimensions (size), detected mime-type and overall validity for a set of image formats. It is the fastest and supports multiple formats.",
      version: "0.2.3",
      elixir: "~> 1.3",
      name: 'ExImageInfo',
      package: package(),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps(),
      docs: docs(),
      source_url: "https://github.com/Group4Layers/ex_image_info",
      homepage_url: "https://www.group4layers.com",
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
      {:ex_doc, "~> 0.18", only: :dev},
      {:inch_ex, "~> 0.5", only: [:dev, :test]},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
    ]
  end

  defp aliases do
    [
      "test_wip": ["test --only wip"],
      "docs": ["docs", &copy_doc_to_docs/1]
    ]
  end

  defp docs do
    [
      extras: ["README.md", "LICENSE.md", "CHANGELOG.md", "CONTRIBUTORS.md"],
      assets: "assets/"
    ]
  end

  defp copy_doc_to_docs(_) do
    # to be used in GitHub Pages (and keep doc for hexpm package)
    File.rm_rf!("docs")
    File.cp_r!("doc", "docs")
    # File.rm_rf!("doc")
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
      maintainers: ["nozalr <nozalr@group4layers.com>"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/Group4Layers/ex_image_info",
        "Docs" => "https://group4layers.github.io/ex_image_info",
        "Organization" => "https://www.group4layers.com",
      }
    ]
  end
end
