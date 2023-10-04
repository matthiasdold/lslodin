// Starting out from the StreamData example at:
// https://github.com/sccn/liblsl/blob/master/examples/SendDataC.c
#include "lsl_c.h"
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

/* Pointers are passed to odins rawptr which is sufficient as we do not need */
/* any pointer arithmetics or other advance pointer usage */

const char *leftmrk = "LEFT";
const char *rightmrk = "RIGHT";

void *lslodin_create_lsloutlet(char *name) {
  lsl_streaminfo info;
  info = lsl_create_streaminfo(name, "Markers", 1, LSL_IRREGULAR_RATE,
                               cft_string, "idLSLODIN");

  lsl_outlet outlet = lsl_create_outlet(info, 0, 360);

  return outlet;
}

// int lslodin_send_lslmarker_left(intptr_t handle) {
int lslodin_send_lslmarker_left(lsl_outlet lsl) {
  lsl_push_sample_str(lsl, &leftmrk);
  return 0;
}

int lslodin_send_lslmarker_right(lsl_outlet lsl) {
  lsl_push_sample_str(lsl, &rightmrk);
  return 0;
}

void lslodin_free_lsloutlet(lsl_outlet outlet) { lsl_destroy_outlet(outlet); }

/* Use for testing */
/* int main(){ */
/*   printf("Hello World"); */
/*   return 0; */
/* } */
