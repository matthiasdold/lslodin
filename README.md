# LSLODIN
The odin language [binds to c lang](https://odin-lang.org/news/binding-to-c/) but
only with some primitive types.
The idea here is to create a c shared object exposing functions with only
basic `c types` [support by the odin language](https://github.com/odin-lang/Odin/blob/master/core/c/c.odin).

## Functionality
The functionality is first only targeted for using an irregular marker stream, as odin-lang's first cannonic use case is the development of paradigms.
- [ ] Send marker via an irregular stream
