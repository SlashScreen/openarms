package main

import "core:math"
import "core:math/linalg"

@(private = "file")
KERNEL :: matrix[3, 3]f16{
	-1.0, -1.0, -1.0,
	-1.0, 8.0, -1.0,
	-1.0, -1.0, -1.0,
}
@(private = "file")
SLOPE_THRESHOLD :: 0.7
@(private = "file")
NEIGHBORS :: [?]Vec2i{{-1, 1}, {0, 1}, {1, 1}, {-1, 0}, {0, 0}, {1, 0}, {-1, -1}, {0, -1}, {1, -1}}

static_obstacles : SparseMap(bool)

@(private = "file")
average_kernel :: proc(vals : matrix[3, 3]f16) -> f16 {
	flat := linalg.matrix_flatten(vals)
	return math.sum(flat[:]) / 9.0
}

@(private = "file")
kernel_from_heightmap :: proc(coords : Vec2i) -> matrix[3, 3]f16 {
	res : matrix[3, 3]f16 = {}
	for point in NEIGHBORS {
		to_grab := coords + point
		assign := point + 1
		res[assign.x, assign.y] = sample_terrain_height({f32(to_grab.x), f32(to_grab.y)})
	}
	return res
}

generate_static_obstacles :: proc() {
	static_obstacles = sparse_map_init(bool, false)

	for x in 0 ..< terrain_size.x {
		for y in 0 ..< terrain_size.y {
			coords := Vec2i{x, y}
			map_kernel := kernel_from_heightmap(coords)
			avg := average_kernel(map_kernel * KERNEL) // I think it's in this order?
			sparse_map_set(&static_obstacles, coords, avg >= SLOPE_THRESHOLD)
		}
	}
}

free_static_obstacles :: proc() {
	sparse_map_deinit(&static_obstacles)
}

draw_static_obstacles :: proc() {

}

setup_static_obstacles_debug :: proc() {

}

