package server

import cm "../common"
import sm "../slot_map"
import "core:fmt"
import la "core:math/linalg"
import "core:time"

TPS :: 20
NANOS_PER_TICK :: 1_000_000_000 / TPS
TARGET_DISTANCE :: 0.5

UnitID :: cm.UnitID

units: sm.DynamicSlotMap(cm.Unit, UnitID)
timer: time.Tick

sim_init :: proc() {
	units = sm.dynamic_slot_map_make(cm.Unit, UnitID)
	timer = time.tick_now()

	_ = sm.dynamic_slot_map_insert_set(&units, cm.Unit{0, 0, la.identity(cm.Transform), [2]int{0, 6}})
}

sim_tick :: proc() {
	nanos := time.duration_nanoseconds(time.tick_since(timer))
	if nanos >= NANOS_PER_TICK {
		timer = time.tick_now()
		sim_tick_world()
		sim_tick_units()
	}
}

sim_tick_world :: proc() {
}

sim_tick_units :: proc() {
	for i in 0 ..< units.size {
		u := sm.dynamic_slot_map_get_ptr(&units, units.keys[i])
		tgt := [3]f16{f16(u.target.x), 0.0, f16(u.target.y)}

		if la.distance(tgt, u.transform[3].xyz) <= TARGET_DISTANCE {
			continue
		}

		dir := la.normalize(tgt - u.transform[3].xyz) * (1.0 / f16(TPS))
		u.transform += la.matrix4_translate(dir)
	}
}

sim_shutdown :: proc() {
	sm.dynamic_slot_map_delete(&units)
}

sim_gather_keyframe_for_all :: proc() -> []cm.KeyframeData {
	res := make([]cm.KeyframeData, units.size)
    for i in 0 ..< units.size {
		id := units.keys[i]
		u := sm.dynamic_slot_map_get(&units, id)

        res[i] = cm.KeyframeData{
            id,
            u,
        }
	}
    return res
}
