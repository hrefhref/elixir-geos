defmodule Geos do
  @on_load :init

  defstruct [:name, :geom, :prep]

  alias __MODULE__

  def init do
    :erlang.load_nif(:code.priv_dir(:geos) ++ '/geos', 0)
  end

  def contains?(%Geos{prep: nil, geom: geom1}, %Geos{geom: geom2}) do
    geos_contains(geom1, geom2)
  end
  def contains?(%Geos{prep: prep}, %Geos{geom: geom2}) do
    geos_prepared_contains(prep, geom2)
  end
  def distance(%Geos{geom: geom1}, %Geos{geom: geom2}) do
    geos_distance(geom1, geom2)
  end

  def from_geo(geo, prepare \\ true) do
    %{"type" => type, "coordinates" => coords} = Geo.JSON.encode(geo)
    geom = geos_to_geom({String.to_atom(type), coords})
    geom = if geos_is_valid(geom) do
      geom
    else
      {:ok, geom} = geos_buffer(geom)
      geom
    end

    prep = if prepare do
      {:ok, prep} = geos_prepare(geom)
      prep
    else
      nil
    end

    %__MODULE__{geom: geom, prep: prep}
  end

  def geos_to_geom(_geom), do: :erlang.nif_error(:nif_not_loaded)
  def geos_from_geom(_geom), do: :erlang.nif_error(:nif_not_loaded)
  def geos_disjoint(_geom1, _geom2), do: :erlang.nif_error(:nif_not_loaded)
  def geos_get_centroid(_geom), do: :erlang.nif_error(:nif_not_loaded)
  def geos_intersection(_geom1, _geom2), do: :erlang.nif_error(:nif_not_loaded)
  def geos_intersects(_geom1, _geom2), do: :erlang.nif_error(:nif_not_loaded)
  def geos_contains(_geom1, _geom2), do: :erlang.nif_error(:nif_not_loaded)
  def geos_topology_preserve_simplify(_geom, _int), do: :erlang.nif_error(:nif_not_loaded)
  def geos_is_valid(_geom), do: :erlang.nif_error(:nif_not_loaded)
  def geos_buffer(_geom), do: :erlang.nif_error(:nif_not_loaded)
  def geos_distance(_geom1, _geom2), do: :erlang.nif_error(:nif_not_loaded)
  def geos_prepare(_geom), do: :erlang.nif_error(:nif_not_loaded)
  def geos_prepared_contains(_prepared_geom, _geom), do: :erlang.nif_error(:not_loaded)

end
