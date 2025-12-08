package main

import "core:fmt"
import "core:math"
import "vendor:raylib"
// Handles the living state of the game world: unit colliders and queries about them.
// Uses a grid spacial partition scheme.

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
	unit := sm.dynamic_slot_map_get_ptr(&units, id)
	physics_bodies[id] = bounding_box_from_extents(unit.transform[3].xyz, Vec3{1.0, 1.0, 1.0}) // Weird size for debugging
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
	body := physics_bodies[id]
	rect : raylib.Rectangle
	switch b in body {
	case BoundingBox:
		size := (b.max - b.min).xy
		rect.x = b.min.x
		rect.y = b.min.z
		rect.width = size.x
		rect.height = size.y
	case Sphere:
		rect.x = b.position.x - b.radius
		rect.y = b.position.y - b.radius
		rect.width = b.radius * 2.0
		rect.height = b.radius * 2.0
	}

	// Won't work for units over GRID_SIZE foorprint but that's like 16 so it should be fine

	points := [4]Vec2 {
		Vec2{rect.x, rect.y},
		Vec2{rect.x + rect.width, rect.y},
		Vec2{rect.x + rect.width, rect.y + rect.height},
		Vec2{rect.x, rect.y + rect.height},
	}

	for point in points {
		u_cell := la.array_cast(la.floor(point / f32(GRID_SIZE)), int)
		if _, list, _, _ := map_entry(&grid, u_cell); list != nil {
			append(list, id)
			new_length := len(slice.unique(list[:]))
			resize(list, new_length)
			//log("modifying ID list: %v", list)
			// I love Performance
		} else {
			list := make([dynamic]UnitID)
			append(&list, id)
			grid[u_cell] = list
			//log("adding ID list: %v", list)
		}
	}
}

query_ray :: proc(ray : Ray, max_dist : f32) -> (UnitID, bool) {
	START :: 0
	END :: 1

	debug_render_command : RenderCommand3D = DrawLine3D {
		Vec3{ray.position.x, 0.0, ray.position.z},
		{
			(ray.position + ray.direction * max_dist).x,
			0.0,
			(ray.position + ray.direction * max_dist).z,
		},
		Color{0, 0, 255, 255},
	}
	broadcast("enqueue_3D", &debug_render_command)

	projection := [2]Vec2i {
		into_cell_coords(ray.position),
		into_cell_coords((ray.position + ray.direction * max_dist)),
	} // Projection to 2d plane

	dx := abs(projection[END].x - projection[START].x)
	dy := abs(projection[END].y - projection[START].y)
	sx := 1 if projection[END].x > projection[START].x else -1
	sy := 1 if projection[END].y > projection[START].y else -1

	point := projection[START]

	if dx > dy {
		err := dx / 2
		for {

			if id, ok := check_ray_cell(point, ray); ok do return id, true
			if point == projection[END] do break

			point.x += sx
			err -= dy
			if err < 0 {
				point.y += sy
				err += dx
			}
		}
	} else {
		err := dy / 2
		for {

			if id, ok := check_ray_cell(point, ray); ok do return id, true
			if point == projection[END] do break

			point.y += sy
			err -= dx
			if err < 0 {
				point.x += sx
				err += dy
			}
		}
	}

	return UnitID{}, false
}

check_ray_cell :: proc(cell : Vec2i, ray : Ray) -> (UnitID, bool) {
	if list, ok := grid[cell]; ok {
		log("Checking cell %v", cell)

		for u_id in list {
			log("there is a body: %v", u_id)
			body := physics_bodies[u_id]
			switch b in body {
			case BoundingBox:
				if _, ok := ray_box_intersect(ray, b); ok {
					log("Collided with the box")
					return u_id, true
				}
			case Sphere:
				if _, ok := ray_sphere_intersect(ray, b); ok {
					log("Collided with sphere")
					return u_id, true
				}
			}
		}
	}
	return UnitID{}, false
}

physics_world_debug_view :: proc() {
	for id, body in physics_bodies {
		unit := sm.dynamic_slot_map_get_ptr(&units, id)
		switch b in body {
		case Sphere:
		case BoundingBox:
			command : RenderCommand3D = DrawWireCube {
				bounding_box_center(b),
				bounding_box_extents(b) * 2.0,
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

		/* text_command : RenderCommand3D = DrawText3D {
			fmt.aprintf("(%d,%d)", cell.x, cell.y),
			Vec3{cell_center.x, 0.0, cell_center.y},
		}
		broadcast("enqueue_3D", &text_command)*/
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

