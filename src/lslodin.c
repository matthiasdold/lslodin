// Starting out from the StreamData example at:
// https://github.com/sccn/liblsl/blob/master/examples/SendDataC.c
#include "../include/lsl_c.h"
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#ifdef _WIN32
#define WIN32_LEAN_AND_MEAN
#include <Windows.h>
void sleep_(int ms) { Sleep(ms); }
#else
#include <unistd.h>
void sleep_(int ms) { usleep(ms * 1000); }
#endif

/* This might be the solution to the opaque type of the lsl_c.h
 * https://wiki.sei.cmu.edu/confluence/display/c/INT36-C.+Converting+a+pointer+to+integer+or+integer+to+pointer
 */

/**
 * Prepare code to compile into a shared library:
 */

typedef struct {
  lsl_outlet outlet;
} lsloutlet_struct;

const char *leftmrk = "LEFT";
const char *rightmrk = "LEFT";

/*
 * Create a mytype struct but return a simple in representation of the pointer
 */
intptr_t lslodin_create_lsloutlet_struct(char *name) {

  lsl_streaminfo info;
  info = lsl_create_streaminfo(name, "Markers", 1, LSL_IRREGULAR_RATE,
                               cft_string, "idLSLODIN");

  /* make a new outlet (chunking: default, buffering: 360k markers) */
  lsloutlet_struct *lsl = malloc(sizeof(lsloutlet_struct));

  lsl->outlet = lsl_create_outlet(info, 0, 360);
  intptr_t ptrnbr = (intptr_t)lsl;

  return ptrnbr;
}

int32_t lslodin_send_lslmarker_left(intptr_t handle) {
  printf("C LEFT\n");
  lsloutlet_struct *lsl = (lsloutlet_struct *)handle;
  lsl_push_sample_str(lsl->outlet, &leftmrk);
  return 0;
}

int32_t lslodin_send_lslmarker_right(intptr_t handle) {
  printf("C RIGHT\n");
  lsloutlet_struct *lsl = (lsloutlet_struct *)handle;
  lsl_push_sample_str(lsl->outlet, &rightmrk);
  return 0;
}

void lslodin_free_lsloutlet_struct(intptr_t handle) {
  lsloutlet_struct *lsl = (lsloutlet_struct *)handle;
  free(lsl);
}

int main_test(int argc, char *argv[]) {
  printf("Running main");
  intptr_t handle = lslodin_create_lsloutlet_struct("LSLODIN");
  sleep_(500);
  lslodin_send_lslmarker_left(handle);
  sleep_(500);
  lslodin_send_lslmarker_right(handle);
  sleep_(500);
  lslodin_free_lsloutlet_struct(handle);

  return 0;
}
