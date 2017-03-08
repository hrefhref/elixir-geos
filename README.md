# GEOS NIF for Erlang/Elixir

[GEOS](https://trac.osgeo.org/geos/) (Geometry Engine - Open Source) NIF for Erlang/Elixir.

WIP.

Based on the implementation in [oubiwann/lgeo](https://github.com/oubiwann/lgeo/commits/master/c_src), forked from [caroman/erlgeom](https://github.com/caroman/erlgeom), itself a fork of
[couchbase/erlgeom](https://github.com/couchbaselabs/erlgeom).

Fixes a couple of bugs and adds support for buffer operation and a few prepared geometries functions (`prepare` and `contains`), more to come.

Because most operations in GEOS may take more than 1 ms, this NIF requires Erlang to be compiled with dirty schedulers
support.

Because of bad thread safety in the NIF, to avoid random segmentation fault Erlang needs to be started with `+SDcpu 1:1`
(to run the dirty scheduler in only one thread). This is being worked on.

The API is completely unstable and will change soon (to fix the thread safety issue).

Provides a great high-performance alternative to [Topo]

Needs `geos` and `gmake` to compile.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `geos` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:geos, "~> 0.1.0"}]
end
```

## Usage

Support casting from [Geo](https://github.com/bryanjos/geo) structs:

```
geos1 = GEOS.from_geo(%Geo.MultiPolygon{…})
geos2 = GEOS.from_geo(%Geo.MultiPolygon{…})
GEOS.contains?(geos1, geos2)
```

Unless `false` is passed as a second argument to `GEOS.from_geo`, a prepared geometry will be generated too.
`GEOS.contains?` will use the prepared geometry if it has been generated.

