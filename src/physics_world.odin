package main

import "core:fmt"
// Handles the living state of the game world: unit colliders and queries about them.
// Uses a grid spacial partition scheme.
// TODO: Allow units to be in more than one cell to avoid the Doom blockmap bug

import la "core:math/linalg"
import "core:slice"
import sm "slot_map"

GRID_SIZE :: 16
MAX_CAST_RESULTS :: 32
GROUND_PLANE :: Plane{Vec3{0.0, 0.0, 0.0}, Vec3{0.0, 1.0, 0.0}}

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

query_ray :: proc(ray : Ray, max_dist : f32) -> Maybe(UnitID) {
	START :: 0
	END :: 1

	projection := [2]Vec2i {
		into_cell_coords(ray.position),
		into_cell_coords((ray.position + ray.direction * max_dist)),
	} // Projection to 2d plane

	// Use bresenham's on the projected line
	dx := projection[END].x - projection[START].x
	dy := projection[END].y - projection[START].y
	slope := dy / dx

	x1 := projection[START].x
	x2 := projection[END].x
	is_negative := x1 > x2
	// This monstrosity runs in reverse if it's negative
	for x := x1;
	    (is_negative && x >= x2) || (!is_negative && x <= x2);
	    x += -1 if is_negative else 1 {

		y := slope * (x - projection[START].x) + projection[START].y
		cell := Vec2i{x, y}
		fmt.printfln("Cell on path cell %v", cell)
		// Check each body in each cell against the ray
		if list, ok := grid[cell]; ok {
			fmt.printfln("Checking cell %v", cell)

			for u_id in list {
				body := physics_bodies[u_id]
				switch b in body {
				case BoundingBox:
					if ray_box_intersect(ray, b) != nil do return u_id
				case Sphere:
					if ray_sphere_intersect(ray, b) != nil do return u_id
				}
			}
		}
	}

	return nil
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

	for cell, _ in grid {
		cell_center :=
			la.array_cast((cell * GRID_SIZE), f32) +
			(la.scalar_f32_swizzle2(GRID_SIZE, .x, .x) / 2.0)
		command : RenderCommand3D = DrawWireCube {
			Vec3{cell_center.x, 0.0, cell_center.y},
			Vec3{f32(GRID_SIZE), 64.0, f32(GRID_SIZE)},
			Color{0, 255, 0, 255},
		}
		broadcast("enqueue_3D", &command)
	}
}

into_cell_coords :: proc {
	vec2_into_cell_coords,
	vec3_into_cell_coords,
}

vec2_into_cell_coords :: proc(vec : Vec2) -> Vec2i {
	return la.array_cast(la.floor(vec / f32(GRID_SIZE)), int)
}

vec3_into_cell_coords :: proc(vec : Vec3) -> Vec2i {
	return vec2_into_cell_coords(vec.xy)
}

