defmodule Geos do
  @moduledoc """
  Wrapper of `Geos.Geometry`, envelopes, `Geos.Buffer` and `Geos.PreparedGeometry` for improved performance.
  """
  alias __MODULE__
  alias Geos.{Geometry, PreparedGeometry, Buffer}

  defstruct [:geometry, :prepared, :envelope]
  @type t :: %Geos{geometry: Geos.Geometry.t, prepared: Geos.PreparedGeometry.t, envelope: Geos.Geometry.t}

  @spec from_geo(Geo.Geometry.t, Keyword.t) :: Geos.t
  @doc """
  Loads the `geometry` into Geos, and:

  * ensures it's a valid geometry, otherwise applies `Geos.Buffer.op/1`,
  * build a `Geos.Envelope` for the geometry,
  * build a `Geos.PreparedGeometry`.

  Other functions in `Geos` module will make use of the envelope/prepared geometry directly.
  """
  def from_geo(geo, options \\ []) do
    geom = Geometry.from_geo(geo)
    buffer? = Keyword.get(options, :buffer, true)
    prepare? = Keyword.get(options, :prepare, true)
    envelope? = Keyword.get(options, :envelope, true)

    geometry = if Geometry.valid?(geom) do
      geom
    else
      {:ok, geom} = Buffer.op(geom)
      geom
    end

    prepared = if prepare? do
      {:ok, prepared} = PreparedGeometry.from_geometry(geometry)
      prepared
    end

    envelope = if envelope? do
      {:ok, envelope} = Geometry.envelope(geometry)
      envelope
    end

    %Geos{geometry: geometry, prepared: prepared, envelope: envelope}
  end

  @spec contains?(Geos.t, Geos.t) :: boolean
  @doc "Check if `geom1` contains `geom2`. Uses the envelopes and prepared geometry of `geom1` if they has been computed."
  def contains?(geom1 = %Geos{envelope: envelope1}, geom2 = %Geos{envelope: envelope2}) do
    contains?(geom1, geom2, Geometry.contains?(envelope1, envelope2))
  end
  def contains?(geom1, geom2), do: contains?(geom1, geom2, true)

  @spec distance(Geos.t, Geos.t) :: float
  def distance(%Geos{geometry: geom1}, %Geos{geometry: geom2}) do
    Geometry.distance?(geom1, geom2)
  end

  defp contains?(%Geos{prepared: nil, geometry: geom1}, %Geos{geometry: geom2}, true) do
    Geometry.contains?(geom1, geom2)
  end
  defp contains?(%Geos{prepared: prep}, %Geos{geometry: geom2}, true) do
    PreparedGeometry.contains?(prep, geom2)
  end
  defp contains?(_, _, false), do: false

  defimpl Inspect, for: Geos do
    def inspect(_geos, _) do
      "#Geos<>"
    end
  end

end
