package server

import cm "../common"
import "core:time"

TPS :: 20
NANOS_PER_TICK :: 1_000_000_000 / TPS

timer : time.Tick

server_init :: proc() {
	timer = time.tick_now()
	net_init()
	cm.sim_init()
}

server_tick :: proc() {
	net_tick()
	nanos := time.duration_nanoseconds(time.tick_since(timer))
	if nanos >= NANOS_PER_TICK {
		cm.sim_tick(1.0 / f32(TPS))
		timer = time.tick_now()
	}
}

server_shutdown :: proc() {
	cm.sim_shutdown()
	net_shutdown()
}

