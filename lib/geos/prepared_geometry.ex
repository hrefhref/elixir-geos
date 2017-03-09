defmodule Geos.PreparedGeometry do
  @moduledoc "Prepared Geometries"

  alias __MODULE__
  alias Geos.{Nif, Geometry}

  defstruct [:ref]
  @type t :: %PreparedGeometry{}

  @spec from_geometry(Geometry.t) :: {:ok, PreparedGeometry.t} | :error
  def from_geometry(%Geometry{ref: geom}) do
    case Nif.to_prepared(geom) do
      {:ok, ref} -> {:ok, %PreparedGeometry{ref: ref}}
      _ -> :error
    end
  end

  @spec contains?(PreparedGeometry.t, Geometry.t) :: boolean
  def contains?(%PreparedGeometry{ref: prep}, %Geometry{ref: geom}), do: Nif.prepared_contains(prep, geom)

  defimpl Inspect, for: PreparedGeometry do
    def inspect(_, _), do: "#Geos.PreparedGeometry<>"
  end

end
