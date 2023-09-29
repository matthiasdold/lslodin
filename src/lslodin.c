// Starting out from the StreamData example at:
// https://github.com/sccn/liblsl/blob/master/examples/SendDataC.c
#include "../include/lsl_c.h"
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

/* This might be the solution to the opaque type of the lsl_c.h
 * https://wiki.sei.cmu.edu/confluence/display/c/INT36-C.+Converting+a+pointer+to+integer+or+integer+to+pointer
 */

/**
 * Prepare code to compile into a shared library:
 */

typedef struct {
  int a;
  void *handle;
} mytype;

/*
 * Create a mytype struct but return a simple in representation of the pointer
 */
intptr_t lslodin_create_mytype(int a) {
  mytype *my = malloc(sizeof(mytype));
  my->a = a;
  intptr_t ptrnbr = (intptr_t)my;

  return ptrnbr;
}

void lslodin_setmytypevalue(intptr_t ptrnbr, int a) {
  mytype *my = (mytype *)ptrnbr;
  my->a = a;
}

int lslodin_get_mytypevalue(intptr_t ptrnbr) {
  mytype *my = (mytype *)ptrnbr;
  return my->a;
}

void lslodin_free_mytype(intptr_t ptrnbr) {
  mytype *my = (mytype *)ptrnbr;
  free(my);
}

int lslodin_main(int argc, char *argv[]) {
  printf("Running main");
  return 0;
}
