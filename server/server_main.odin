package server

server_init :: proc() {
	net_init()
	sim_init()
}

server_tick :: proc() {
	net_tick()
	sim_tick()
}

server_shutdown :: proc() {
	sim_shutdown()
	net_shutdown()
}

