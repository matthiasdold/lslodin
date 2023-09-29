package main

import "core:c"
import "core:fmt"

foreign import lslodin "lslodin.a"

foreign lslodin {
  lslodin_create_mytype :: proc(a: c.int) -> int ---
  lslodin_free_mytype :: proc(ptrnbr: int) ---
  lslodin_setmytypevalue :: proc(ptrnbr: int, a: c.int) ---
  lslodin_get_mytypevalue :: proc(ptrnbr: int) -> c.int ---
}

main :: proc() {
	fmt.println("Hello World!")

  mtptrnbr := lslodin_create_mytype(15)
  defer lslodin_free_mytype(mtptrnbr)

  lslodin_setmytypevalue(mtptrnbr, 10)
  x := lslodin_get_mytypevalue(mtptrnbr)
  fmt.println("x = ", x)
}
