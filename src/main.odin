package main


running := true

main :: proc() {
	if #config(HEADLESS, false) {
		headless_main()
	} else {
		default_main()
	}
}

headless_main :: proc() {
	common_init()

	subscribe("shutdown", NIL_USERDATA, close)

	for running {
	}

	common_shutdown()
}

default_main :: proc() {
	common_init()
	client_init()

	subscribe("shutdown", NIL_USERDATA, close)

	for running {
		client_tick()
	}

	client_shutdown()
	common_shutdown()
}

close :: proc(_ : ^int, _ : ^int) {
	running = false
}

