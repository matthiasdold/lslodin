# LSLODIN

The odin language [binds to c lang](https://odin-lang.org/news/binding-to-c/) but
only with some primitive types. The most important aspect however is that implentations of the
`lsl_outlet` from the `LSL C API` can be interpreted as `rawptr` in odin.
This basically solves the interoperability.

I use this repo for trying out basic interaction and potentially will extend it
to some kind of an `odin API` for `LSL` in the future.

## Setup

The make file is currently only made for MacOS with my installation of `liblsl.dylib`, you might want to adjust the `LSLLIB` parameter to your installation path of the `liblsl.*`.
