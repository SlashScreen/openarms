package main

import "client"
import "server"
import "common"

running := true

main :: proc() {
	if #config(HEADLESS, false) {
		headless_main()
	} else {
		default_main()
	}
}

headless_main :: proc() {
	common.common_init()
	server.server_init()

	common.subscribe("shutdown", common.NIL_USERDATA, close)

	for running {
		server.server_tick()
	}

	common.common_shutdown()
	server.server_shutdown()
}

default_main :: proc() {
	common.common_init()
	server.server_init()
	client.client_init()

	common.subscribe("shutdown", common.NIL_USERDATA, close)

	for running {
		server.server_tick()
		client.client_tick()
	}

	common.common_shutdown()
	server.server_shutdown()
	client.client_shutdown()
}

close :: proc(_: ^int, _: ^int) {
	running = false
}
