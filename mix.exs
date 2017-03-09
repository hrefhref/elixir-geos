defmodule Mix.Tasks.Compile.Nif do
  @shortdoc "Compiles GEOS NIF"

  def run(_) do
    {result, _error_code} = System.cmd("gmake", [], stderr_to_stdout: true)
    Mix.shell.info result
  end
end

defmodule Geos.Mixfile do
  use Mix.Project

  def project do
    [app: :geos,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     compilers: [:nif, :elixir, :app],
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger, :geos]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:geo, "~> 1.0"}]
  end
end
