package main

// The simulation for the game, handling unit behavior and the game state.
// Perhaps the most important part of the engine.

import la "core:math/linalg"
import sm "slot_map"

SET_UNIT_TARGET_COMMAND :: "set_unit_target"

UnitSetTargetInfo :: struct {
	uid :    UnitID,
	target : Vec2,
}

units : sm.DynamicSlotMap(Unit, UnitID)

sim_init :: proc() {
	units = sm.dynamic_slot_map_make(Unit, UnitID)
	physics_world_init()

	insert_unit(Unit{0, 0, la.identity(Transform), Vec2{0.0, 6.0}, false})
	subscribe(SET_UNIT_TARGET_COMMAND, NIL_USERDATA, sim_set_unit_target)
}

insert_unit :: proc(u : Unit) {
	id := sm.dynamic_slot_map_insert_set(&units, u)
	physics_insert_unit(id)
}

sim_tick :: proc(dt : f32) {
	sim_tick_world()
	sim_tick_units(dt)
}

sim_tick_world :: proc() {
	physics_world_tick()
}

sim_tick_units :: proc(dt : f32) {
	for i in 0 ..< units.size {
		u := sm.dynamic_slot_map_get_ptr(&units, units.keys[i])
		tgt := Vec3{u.target.x, 0.0, u.target.y}

		if la.distance(tgt, u.transform[3].xyz) <= TARGET_DISTANCE {
			u.moving = false
			continue
		}

		dir := la.normalize(tgt - u.transform[3].xyz) * dt
		u.transform *= la.matrix4_translate(dir)
		u.moving = true
	}
}

sim_shutdown :: proc() {
	sm.dynamic_slot_map_delete(&units)
	physics_world_deinit()
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

sim_set_units_target :: proc(uids : []UnitID, target : Vec2) {
	for uid in uids {
		unit := sm.dynamic_slot_map_get_ptr(&units, uid)
		unit.target = target
	}
}

sim_set_unit_target :: proc(_ : ^int, packet : ^UnitSetTargetInfo) {
	unit := sm.dynamic_slot_map_get_ptr(&units, packet.uid)
	unit.target = packet.target
}

