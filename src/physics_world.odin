package main

// Handles the living state of the game world: unit colliders and queries about them.
// Uses a grid spacial partition scheme.

import la "core:math/linalg"
import "core:slice"
import sm "slot_map"

GRID_SIZE :: 16
MAX_CAST_RESULTS :: 32

physics_bodies : map[UnitID]PhysicsShape
grid : map[Vec2i][dynamic]UnitID

physics_world_init :: proc() {
	grid = make(map[Vec2i][dynamic]UnitID)
	physics_bodies = make(map[UnitID]PhysicsShape)
}

physics_world_deinit :: proc() {
	for _, &v in grid {
		delete(v)
	}
	delete(grid)
	delete(physics_bodies)
}

physics_insert_unit :: proc(id : UnitID) {
	physics_partition(id)
}

physics_remove_unit :: proc(id : UnitID) {
	unit := sm.dynamic_slot_map_get_ptr(&units, id)
	u_cell := la.array_cast(la.floor(unit.transform[3].xy / f32(GRID_SIZE)), int)
	if _, ok := grid[u_cell]; !ok do return // Should never happen

	#reverse for u_id, idx in grid[u_cell] {
		if id == u_id {
			unordered_remove(&grid[u_cell], idx)
			break
		}
	}
}

update_partition_grid :: proc() {
	to_update := make([dynamic]UnitID)
	defer delete(to_update)

	for k, &v in grid {
		#reverse for id, index in v {
			unit := sm.dynamic_slot_map_get_ptr(&units, id)
			if !unit.moving do continue

			u_cell := la.array_cast(la.floor(unit.transform[3].xy / f32(GRID_SIZE)), int)
			if u_cell == k do continue

			if !slice.contains(to_update[:], id) do append(&to_update, id)

			unordered_remove(&v, index)
		}
	}

	for id in to_update {
		physics_partition(id)
	}
}

physics_partition :: proc(id : UnitID) {
	unit := sm.dynamic_slot_map_get_ptr(&units, id)
	u_cell := la.array_cast(la.floor(unit.transform[3].xy / f32(GRID_SIZE)), int)
	if list, ok := grid[u_cell]; ok {
		append(&list, id)
	} else {
		list := make([dynamic]UnitID)
		append(&list, id)
		grid[u_cell] = list
	}
}

query_ray :: proc(ray : Ray) -> Maybe(UnitID) {
	return nil // TODO
}

