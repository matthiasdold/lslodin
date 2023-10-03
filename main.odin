// Some benchmarking code example sending key presses for left and right to LSL
package main

import "core:c"
import "core:fmt"
import "core:log"
import "core:math/rand"
import "core:time"

import SDL "vendor:sdl2"
import SDL_TTF "vendor:sdl2/ttf"


foreign import lslodin "./include/liblslodin.a"

foreign lslodin {
	lslodin_create_lsloutlet_struct :: proc(name: string) -> c.int ---
	lslodin_send_lslmarker_left :: proc(handle_ptr_i: c.int) -> c.int ---
	lslodin_send_lslmarker_right :: proc(handle_ptr_i: c.int) -> c.int ---
	lslodin_free_lsloutlet_struct :: proc(handle_ptr_i: c.int) ---
}

// Create a window to be closer to the real application in terms of load
RENDER_FLAGS :: SDL.RENDERER_ACCELERATED
// WINDOW_FLAGS :: SDL.WINDOW_SHOWN | SDL.WINDOW_RESIZABLE
WINDOW_FLAGS :: SDL.WINDOW_SHOWN
WINDOW_TITLE :: "STROOP Paradigm"
WINDOW_X: i32 = SDL.WINDOWPOS_UNDEFINED // for centering
WINDOW_Y: i32 = SDL.WINDOWPOS_UNDEFINED
WINDOW_WIDTH: i32 = 1000
WINDOW_HEIGHT: i32 = 1000

CTX :: struct {
	renderer:               ^SDL.Renderer,
	font:                   ^SDL_TTF.Font,
	window:                 ^SDL.Window,
	window_h:               i32,
	window_w:               i32,
	font_size:              i32,

	// some parameters for the task
	response_time_s:        f32,
	inter_trial_time_min_s: f32,
	inter_trial_time_max_s: f32,
	n_trials:               i32,
}

ctx := CTX {
	window_h  = WINDOW_HEIGHT,
	window_w  = WINDOW_WIDTH,
	font_size = 64,
}

main :: proc() {
	// use a filelogger alongside console

	init_sdl()
	defer clean_sdl()

	lslhandle := lslodin_create_lsloutlet_struct("StroopParadigmMarkerStream")

	process_keypress(lslhandle)

	// high precision timer
	start_tick := time.tick_now()
}

init_sdl :: proc() {
	SDL.Init({.VIDEO})

	ctx.window = SDL.CreateWindow(
		"Odin STROOP demo",
		SDL.WINDOWPOS_UNDEFINED,
		SDL.WINDOWPOS_UNDEFINED,
		WINDOW_WIDTH,
		WINDOW_HEIGHT,
		WINDOW_FLAGS,
	)
	if ctx.window == nil {
		fmt.eprintln("Failed to create window")
		return
	}

	// This should also be the place to switch back to openGL if needed
	// Renderer
	// This is used throughout the program to render everything.
	// You only require ONE renderer for the entire program.
	ctx.renderer = SDL.CreateRenderer(ctx.window, -1, RENDER_FLAGS)
	assert(ctx.renderer != nil, SDL.GetErrorString())
}

process_keypress :: proc(lslhandle: c.int) -> string {
	resp: string = "timeout"
	response_loop: for {
		event: SDL.Event
		for SDL.PollEvent(&event) {
			#partial switch event.type {
			case .KEYDOWN:
				#partial switch event.key.keysym.sym {
				case .LEFT:
					resp = "left"
					fmt.printf("O - left\n")
					lslodin_send_lslmarker_left(lslhandle)
				case .RIGHT:
					resp = "right"
					fmt.printf("O - right\n")
					lslodin_send_lslmarker_right(lslhandle)
				case .ESCAPE:
					resp = "quit"
					break response_loop
				}
			case .QUIT:
				resp = "quit"
				break response_loop
			}
		}

	}

	return resp
}

clean_sdl :: proc() {
	SDL.Quit()
	SDL_TTF.Quit()
	SDL.DestroyWindow(ctx.window)
	SDL.DestroyRenderer(ctx.renderer)
}
