package main

// ENtry point.

running := true

main :: proc() {
	if #config(HEADLESS, false) {
		headless_main()
	} else {
		default_main()
	}
}

headless_main :: proc() {

	subscribe("shutdown", NIL_USERDATA, close)

	for running {
	}
}

default_main :: proc() {
	client_init()

	subscribe("shutdown", NIL_USERDATA, close)

	for running {
		client_tick()
	}

	client_shutdown()
}

close :: proc(_ : ^int, _ : ^int) {
	running = false
}

