defmodule Geos.Geometry do
  @moduledoc "Geometry operations"

  alias __MODULE__
  alias Geos.Nif

  defstruct [:ref]
  @type t :: %Geometry{}

  @spec from_geo(Geo.Geometry.t) :: Geometry.t
  def from_geo(geometry) do
    %{"type" => type, "coordinates" => coords} = Geo.JSON.encode(geometry)
    ref = Nif.to_geom({String.to_atom(type), coords})
    %Geometry{ref: ref}
  end

  @spec intersection(Geometry.t, Geometry.t) :: Geometry.t
  def intersection(%Geometry{ref: geom1}, %Geometry{ref: geom2}), do: Nif.geom_intersection(geom1, geom2)

  @spec envelope(Geometry.t) :: {:ok, Geometry.t} | :error
  def envelope(%Geometry{ref: geom}) do
    case Nif.geom_envelope(geom) do
      {:ok, ref} -> {:ok, %Geometry{ref: ref}}
      _ -> :error
    end
  end

  @spec topology_preserve_simplify(Geometry.t, integer) :: Geometry.t
  def topology_preserve_simplify(%Geometry{ref: geom}, int), do: Nif.geom_topology_preserve_simplify(geom, int)

  @spec disjoint?(Geometry.t, Geometry.t) :: boolean
  def disjoint?(%Geometry{ref: geom1}, %Geometry{ref: geom2}), do: Nif.geom_disjoint(geom1, geom2)

  @spec valid?(Geometry.t) :: boolean
  def valid?(%Geometry{ref: geom}), do: Nif.geom_is_valid(geom)

  @spec intersects?(Geometry.t, Geometry.t) :: boolean
  def intersects?(%Geometry{ref: geom1}, %Geometry{ref: geom2}), do: Nif.geom_intersects(geom1, geom2)

  @spec contains?(Geometry.t, Geometry.t) :: boolean
  def contains?(%Geometry{ref: geom1}, %Geometry{ref: geom2}), do: Nif.geom_contains(geom1, geom2)

  @spec distance(Geometry.t, Geometry.t) :: float
  def distance(%Geometry{ref: geom1}, %Geometry{ref: geom2}), do: Nif.geom_distance(geom1, geom2)

  @spec get_centroid(Geometry.t) :: :todo
  def get_centroid(%Geometry{ref: geom}), do: Nif.geom_get_centroid(geom)

  defimpl Inspect, for: Geometry do
    def inspect(_, _), do: "#Geos.Geometry<>"
  end

end
