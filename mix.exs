defmodule Eticket.MixProject do
  use Mix.Project

  def project do
    [
      app: :eticket,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Eticket.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:gen_stage, "~> 0.14"},
      {:redix, "~> 0.8.2"},
      {:protobuf, "~> 0.5.4"},
      {:sentry, "~> 7.0"},
      {:jason, "~> 1.1"}
    ]
  end
end
