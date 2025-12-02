package common

import sm "../slot_map"
import la "core:math/linalg"
import "core:time"

TARGET_DISTANCE :: 0.1

units : sm.DynamicSlotMap(Unit, UnitID)

sim_init :: proc() {
	units = sm.dynamic_slot_map_make(Unit, UnitID)

	_ = sm.dynamic_slot_map_insert_set(&units, Unit{0, 0, la.identity(Transform), [2]int{0, 6}})
}

sim_tick :: proc(dt : f32) {
	sim_tick_world()
	sim_tick_units(dt)
}

sim_tick_world :: proc() {
}

sim_tick_units :: proc(dt : f32) {
	for i in 0 ..< units.size {
		u := sm.dynamic_slot_map_get_ptr(&units, units.keys[i])
		tgt := [3]f32{f32(u.target.x), 0.0, f32(u.target.y)}

		if la.distance(tgt, u.transform[3].xyz) <= TARGET_DISTANCE {
			continue
		}

		dir := la.normalize(tgt - u.transform[3].xyz) * dt
		u.transform *= la.matrix4_translate(dir)
	}
}

sim_shutdown :: proc() {
	sm.dynamic_slot_map_delete(&units)
}

sim_gather_keyframe_for_all :: proc() -> []KeyframeData {
	res := make([]KeyframeData, units.size)
	for i in 0 ..< units.size {
		id := units.keys[i]
		u := sm.dynamic_slot_map_get(&units, id)

		res[i] = KeyframeData{id, u}
	}
	return res
}

sim_set_units_target :: proc(uids : []UnitID, target : Vec2i) {
	for uid in uids {
		unit := sm.dynamic_slot_map_get_ptr(&units, uid)
		unit.target = target
	}
}

