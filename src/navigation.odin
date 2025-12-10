package main

import "core:math"
import "core:math/linalg"

@(private = "file")
KERNEL_SOBEL_L :: matrix[3, 3]f16{
	1.0, 0.0, -1.0,
	2.0, 0.0, -2.0,
	1.0, 0.0, -1.0,
}
@(private = "file")
KERNEL_SOBEL_T :: matrix[3, 3]f16{
	1.0, 2.0, 1.0,
	0.0, 0.0, 0.0,
	-1.0, -2.0, -1.0,
}
@(private = "file")
KERNEL_SOBEL_R :: matrix[3, 3]f16{
	-1.0, 0.0, 1.0,
	-2.0, 0.0, 2.0,
	-1.0, 0.0, 1.0,
}
@(private = "file")
KERNEL_SOBEL_B :: matrix[3, 3]f16{
	1.0, 2.0, 1.0,
	0.0, 0.0, 0.0,
	-1.0, -2.0, -1.0,
}
@(private = "file")
KERNEL_OUTLINE :: matrix[3, 3]f16{
	-1.0, -1.0, -1.0,
	-1.0, 8.0, -1.0,
	-1.0, -1.0, -1.0,
}

@(private = "file")
SLOPE_THRESHOLD :: 2.0
@(private = "file")
NEIGHBORS :: [?]Vec2i{{-1, 1}, {0, 1}, {1, 1}, {-1, 0}, {0, 0}, {1, 0}, {-1, -1}, {0, -1}, {1, -1}}

static_obstacles : SparseMap(bool)

@(private = "file")
debug_img_static_obstacles : AssetID
@(private = "file")
debug_mat_static_obstacles : ResourceID

navigation_init :: proc() {
	generate_static_obstacles()
}

navigation_deinit :: proc() {
	free_static_obstacles()
}

navigation_draw :: proc() {
	if .StaticObstacles in debug_views do draw_static_obstacles()
}

@(private = "file")
average_kernel :: proc(vals : matrix[3, 3]f16) -> f16 {
	flat := linalg.matrix_flatten(vals)
	return math.sum(flat[:])
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

@(private = "file")
generate_static_obstacles :: proc() {
	static_obstacles = sparse_map_init(bool, false)

	for x in 0 ..< terrain_size.x {
		for y in 0 ..< terrain_size.y {
			coords := Vec2i{x, y}
			map_kernel := kernel_from_heightmap(coords)
			avg := max(
				average_kernel(linalg.hadamard_product(map_kernel, KERNEL_SOBEL_L)),
				average_kernel(linalg.hadamard_product(map_kernel, KERNEL_SOBEL_R)),
				average_kernel(linalg.hadamard_product(map_kernel, KERNEL_SOBEL_T)),
				average_kernel(linalg.hadamard_product(map_kernel, KERNEL_SOBEL_B)),
			) // I think it's in this order?
			//log_debug("%f", avg)
			sparse_map_set(&static_obstacles, coords, avg >= SLOPE_THRESHOLD)
		}
	}
}

@(private = "file")
free_static_obstacles :: proc() {
	sparse_map_deinit(&static_obstacles)
}

@(private = "file")
draw_static_obstacles :: proc() {
	if debug_mat_static_obstacles == {} do setup_static_obstacles_debug()

	command : RenderCommand3D = DrawMesh {
		terrain_mesh,
		debug_mat_static_obstacles,
		linalg.MATRIX4F32_IDENTITY * linalg.matrix4_translate_f32({0.0, 0.1, 0.0}),
		false,
	}

	broadcast(ENQUEUE_3D_COMMAND, &command)
}

@(private = "file")
setup_static_obstacles_debug :: proc() {
	debug_img_static_obstacles = asset_db_new_image(
		i32(terrain_size.x),
		i32(terrain_size.y),
		C_CLEAR,
	)
	img := &(unwrap_asset_handle(debug_img_static_obstacles).(Image))

	for k, v in static_obstacles.values {
		if v do image_set_pixel(img, k, Color{255, 255, 0, 255})
	}
	tex := create_texture_from_image(debug_img_static_obstacles)
	debug_mat_static_obstacles = create_material_default()
	set_material_albedo(debug_mat_static_obstacles, tex)
}

