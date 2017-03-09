defmodule Geos.Buffer do
  @moduledoc "Buffer operations"

  alias Geos.{Nif, Geometry}

  @spec op(Geometry.t) :: {:ok, Geometry.t} | :error
  def op(%Geometry{ref: geom}) do
    case Nif.buffer_op(geom) do
      {:ok, geom2} -> {:ok, %Geometry{ref: geom2}}
      err -> err
    end
  end

end
