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

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
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
      files: [
        "lib",
        "README.md",
        "LICENSE.md",
        "CHANGELOG.md",
        "CONTRIBUTORS.md",
        "mix.exs",
      ],
      maintainers: ["rNoz <rnoz.commits@gmail.com>"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/rNoz/ex_image_info"}
    ]
  end
end
