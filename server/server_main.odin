package server

server_init :: proc() {
    net_init()
    sim_init()
}

server_tick :: proc() {
    sim_tick()
}

server_shutdown :: proc() {
    sim_shutdown()
    net_shutdown()
}
