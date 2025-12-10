package main

import "core:math"
import "core:math/linalg"

@(private = "file")
SLOPE_THRESHOLD :: 0.3

static_navmap : SparseMap(bool)

@(private = "file")
debug_img_static_navmap : AssetID
@(private = "file")
debug_mat_static_navmap : ResourceID

navigation_init :: proc() {
	generate_static_navmap()
}

navigation_deinit :: proc() {
	free_static_navmap()
}

navigation_draw :: proc() {
	if .StaticObstacles in debug_views do draw_static_navmap()
}


@(private = "file")
generate_static_navmap :: proc() {
	static_navmap = sparse_map_init(bool, true)

	for x in 0 ..< terrain_size.x {
		for y in 0 ..< terrain_size.y {
			coords := Vec2i{x, y}
			normals := sample_terrain_normals(coords)
			angle := linalg.dot(normals, linalg.Vector3f16{0.0, 1.0, 0.0})
			//log_debug("angle %f, %t", angle, angle < SLOPE_THRESHOLD)
			// 1.0 is flat
			sparse_map_set(&static_navmap, coords, angle > SLOPE_THRESHOLD)
		}
	}
}

@(private = "file")
free_static_navmap :: proc() {
	sparse_map_deinit(&static_navmap)
}

@(private = "file")
draw_static_navmap :: proc() {
	if debug_mat_static_navmap == {} do setup_static_navmap_debug()

	command : RenderCommand3D = DrawMesh {
		terrain_mesh,
		debug_mat_static_navmap,
		linalg.MATRIX4F32_IDENTITY * linalg.matrix4_translate_f32({0.0, 0.1, 0.0}),
		false,
	}

	broadcast(ENQUEUE_3D_COMMAND, &command)
}

@(private = "file")
setup_static_navmap_debug :: proc() {
	debug_img_static_navmap = asset_db_new_image(i32(terrain_size.x), i32(terrain_size.y), C_CLEAR)
	img := &(unwrap_asset_handle(debug_img_static_navmap).(Image))

	for x in 0 ..< terrain_size.x {
		for y in 0 ..< terrain_size.y {
			image_set_pixel(
				img,
				Vec2i{x, y},
				Color{255, 255, 0, 255} if sparse_map_get(&static_navmap, Vec2i{x, y}) else C_CLEAR,
			)
		}
	}
	for k, v in static_navmap.values {
		if v do image_set_pixel(img, k, Color{255, 255, 0, 255})
	}
	tex := create_texture_from_image(debug_img_static_navmap)
	debug_mat_static_navmap = create_material_default()
	set_material_albedo(debug_mat_static_navmap, tex)
}

