CFLAGS = -fPIC -O1 -Wno-unused-parameter

ERLANG_PATH = $(shell erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)
GEOS_CFLAGS = $(shell geos-config --cflags)
GEOS_LDFLAGS = $(shell geos-config --clibs)

CFLAGS += -I$(ERLANG_PATH)
CFLAGS += -Isrc
CFLAGS += $(GEOS_CFLAGS)

LDFLAGS += $(GEOS_LDFLAGS)

.PHONY: all clean
all: priv/geos.so

priv/geos.so: c_src/geos.c
	clang $(CFLAGS) -shared $(LDFLAGS) -o $@ c_src/geos.c

clean:
	$(RM) -r priv/geos.so*

