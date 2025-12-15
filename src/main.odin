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
	log("Entering error screen...")
	error_screen_init()

	for !raylib.WindowShouldClose() {
		raylib.BeginDrawing()
		error_screen_draw(raylib.GetFrameTime())
		raylib.EndDrawing()
	}

	error_screen_deinit()
	raylib.CloseWindow()
}

