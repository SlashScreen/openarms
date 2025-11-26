package server

import "core:time"
import la "core:math/linalg"
import cm "../common"

TPS :: 20
NANOS_PER_TICK :: 1_000_000_000 / TPS
TARGET_DISTANCE :: 0.5

units: #soa [dynamic]cm.Unit
sim_timer: time.Stopwatch

sim_init :: proc() {
    units = make(#soa [dynamic]cm.Unit)
    sim_timer = time.Stopwatch{}
    time.stopwatch_start(&sim_timer)
}

sim_tick :: proc() {
    _, _, _, nanos := time.precise_clock_from_stopwatch(sim_timer)
    if nanos >= NANOS_PER_TICK {
        time.stopwatch_reset(&sim_timer)
        sim_tick_world()
        sim_tick_units()
    }
}

sim_tick_world :: proc() {
}

sim_tick_units :: proc() {
    for &u in units {
        tgt := [3]f32{f32(u.target.x), 0.0, f32(u.target.y)}

        if la.distance(tgt, u.transform[3].xyz) <= TARGET_DISTANCE {
            continue
        }

        dir := la.normalize(tgt - u.transform[3].xyz) * (1.0 / f32(TPS))
        u.transform += la.matrix4_translate(dir)
    }
}

sim_shutdown :: proc() {
    delete(units)
}