defmodule CodebeamCamp.MixProject do
  use Mix.Project

  def project do
    [
      app: :codebeam_camp,
      version: "0.2.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {CodebeamCamp.Application, []},
      extra_applications: [:logger, :runtime_tools, :wx, :observer]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.3"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_view, github: "phoenixframework/phoenix_live_view"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:elixir_uuid, "~> 1.2"},
      {:bamboo, "~> 1.2"},
      {:bamboo_mailjet, git: "https://github.com/fpalluel/bamboo_mailjet"},
      {:gettext, "~> 0.11"},
      {:persistent_ets, "~> 0.2.0"},
      {:jason, "~> 1.0"},
      {:distillery, "~> 2.0", runtime: false},
      {:plug_cowboy, "~> 2.0"}
    ]
  end
end
