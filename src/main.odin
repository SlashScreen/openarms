package main

import "vendor:raylib"
// Entry point.


main :: proc() {
	default_main()
}


default_main :: proc() {
	ok := client_init()
	if !ok do error_main()
}

error_main :: proc() {
	error_screen_init()

	for !raylib.WindowShouldClose() {
		error_screen_draw(raylib.GetFrameTime())
	}

	error_screen_deinit()
	raylib.CloseWindow()
}

