defmodule Geos.Nif do
  @moduledoc false
  @on_load :init

  def init do
    :erlang.load_nif(:code.priv_dir(:geos) ++ '/geos', 0)
  end

  @doc false
  def to_geom(_geom), do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  def from_geom(_geom), do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  def geom_disjoint(_geom1, _geom2), do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  def geom_get_centroid(_geom), do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  def geom_intersection(_geom1, _geom2), do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  def geom_envelope(_geom1), do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  def geom_intersects(_geom1, _geom2), do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  def geom_contains(_geom1, _geom2), do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  def geom_topology_preserve_simplify(_geom, _int), do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  def geom_is_valid(_geom), do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  def geom_distance(_geom1, _geom2), do: :erlang.nif_error(:nif_not_loaded)

  ## -- Buffer

  @doc false
  def buffer_op(_geom), do: :erlang.nif_error(:nif_not_loaded)

  ## -- Prepared Geometries
  def to_prepared(_geom), do: :erlang.nif_error(:nif_not_loaded)
  def prepared_contains(_prepared_geom, _geom), do: :erlang.nif_error(:not_loaded)

end
