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
	unit := sm.dynamic_slot_map_get_ptr(&units, id)
	physics_bodies[id] = bounding_box_from_extents(unit.transform[3].xyz, Vec3{1.0, 5.0, 1.0}) // Weird size for debugging
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

physics_world_tick :: proc() {
	update_partition_grid()
	update_body_positions()
	if DebugViews.PhysicsWorld in debug_views do physics_world_debug_view()
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

update_body_positions :: proc() {
	for id, &body in physics_bodies {
		unit := sm.dynamic_slot_map_get_ptr(&units, id)
		if !unit.moving do continue

		switch &b in body {
		case Sphere:
			b.position = unit.transform[3].xyz
		case BoundingBox:
			set_bounding_box_center(&b, unit.transform[3].xyz)
		}
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

physics_world_debug_view :: proc() {
	for id, body in physics_bodies {
		unit := sm.dynamic_slot_map_get_ptr(&units, id)
		switch b in body {
		case Sphere:
		case BoundingBox:
			command : RenderCommand3D = DrawWireCube {
				bounding_box_center(b),
				bounding_box_extents(b),
				Color{255, 0, 0, 255},
			}
			broadcast("enqueue_3D", &command)
		}
	}
}

