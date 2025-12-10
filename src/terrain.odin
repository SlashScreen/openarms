package main

import "core:math"
// Terrain for the game map.

import la "core:math/linalg"

TEST_HEIGHTMAP :: "test_heightmap.png"

terrain_mesh : ResourceID
@(private = "file")
terrain_tex : ResourceID
@(private = "file")
terrain_mat : ResourceID
@(private = "file")
bounds : Vec3
terrain_size : Vec2i
@(private = "file")
heights : []f16
@(private = "file")
normals : []la.Vector3f16
@(private = "file")
height_cache : map[Vec2]f16

terrain_init :: proc() {
	load_terrain(TEST_HEIGHTMAP, 6.0)
}

terrain_deinit :: proc() {
	unload_terrain()
}

load_terrain :: proc(fp : string, max_height : f32) {
	hmap, ok := asset_db_load_image(fp)
	if !ok {
		log_err("failed to load image")
		return
	}
	defer asset_destroy(hmap)

	hmap_img := unwrap_asset_handle(hmap).(Image)
	bounds = Vec3{f32(hmap_img.width), max_height, f32(hmap_img.height)}
	terrain_size = Vec2i{int(hmap_img.width), int(hmap_img.height)}

	terr, tok := create_heightmap_mesh(hmap, bounds)
	if !tok {
		log_err("failed to create mesh")
		return
	}

	terrain_mesh = terr
	mesh_asset := unwrap_resource_handle(terrain_mesh).(Mesh)
	add_terrain_mesh({mesh_asset, la.MATRIX4F32_IDENTITY})

	tex_ok : bool
	terrain_tex, tex_ok = create_texture_from_image(hmap)
	if !tex_ok {
		log_err("failed to create terrain texture")
		return
	}

	mat_ok : bool
	terrain_mat, mat_ok = create_material_default()
	if !mat_ok {
		log_err("failed to load material")
		return
	}

	set_material_albedo(terrain_mat, terrain_tex)

	heights = make([]f16, terrain_size.x * terrain_size.y)
	for x in 0 ..< terrain_size.x {
		for y in 0 ..< terrain_size.y {
			pt := Vec2i{x, y}
			idx := coords_to_index(pt)
			color := image_get_pixel(hmap_img, pt)
			heights[idx] = f16(color.r) / f16(255) * f16(max_height)
		}
	}

	normals = make([]la.Vector3f16, terrain_size.x * terrain_size.y)
	for x in 0 ..< terrain_size.x {
		for y in 0 ..< terrain_size.y {
			pt := Vec2i{x, y}
			idx := coords_to_index(pt)

			height := sample_terrain_height_vec2i(pt)
			u := sample_terrain_height_vec2i(pt + Vec2i{1, 0})
			v := sample_terrain_height_vec2i(pt + Vec2i{0, 1})
			normals[idx] = la.normalize(la.Vector3f16{u, 1.0, v})
		}
	}

	log("Loaded terrain")
}

unload_terrain :: proc() {
	resource_destroy(terrain_mesh)
	resource_destroy(terrain_mat)
	resource_destroy(terrain_tex)
	delete(heights)
	delete(normals)
	//remove_terrain_mesh() // Will this be an issue?
}

terrain_draw :: proc() {
	command : RenderCommand3D = DrawMesh {
		terrain_mesh,
		terrain_mat,
		la.identity_matrix(Transform),
		false,
	}
	broadcast("enqueue_3D", &command)
}

point_within_terrain_area :: proc(point : Vec3) -> bool {
	return point.x >= 0.0 && point.x <= bounds.x && point.z >= 0.0 && point.z <= bounds.z
}

sample_terrain_height :: proc {
	sample_terrain_height_vec2,
	sample_terrain_height_vec2i,
}

sample_terrain_height_vec2i :: proc(point : Vec2i) -> f16 {
	return heights[coords_to_index(point)]
}

sample_terrain_height_vec2 :: proc(point : Vec2) -> f16 {
	x := int(math.floor(point.x))
	x_rem := la.fract(point.x)
	y := int(math.floor(point.y))
	y_rem := la.fract(point.y)

	// edge case 1:
	if x < 0 || x >= terrain_size.x || y < 0 || y >= terrain_size.y do return 0.0
	// literal edge case 2:
	if x == 0 || x == terrain_size.x - 1 || y == 0 || y == terrain_size.y - 1 do return heights[coords_to_index(Vec2i{x, y})]

	// if a whole number, just grab it
	if x_rem == 0.0 && y_rem == 0.0 {
		return heights[coords_to_index(Vec2i{x, y})]
	}

	origin_height := heights[coords_to_index(Vec2i{x, y})]
	right_height := heights[coords_to_index(Vec2i{x + 1, y})]
	up_height := heights[coords_to_index(Vec2i{x, y + 1})]

	x_interp :=
		math.lerp(origin_height, right_height, f16(x_rem)) if x_rem != 0.0 else origin_height
	y_interp := math.lerp(origin_height, up_height, f16(y_rem)) if y_rem != 0.0 else origin_height
	height_interp := (x_interp + y_interp) / f16(2.0)

	return height_interp
}

@(private = "file")
coords_to_index :: proc(point : Vec2i) -> int {
	return (point.y * terrain_size.x) + point.x
}

@(private = "file")
index_to_coords :: proc(idx : int) -> Vec2i {
	return Vec2i{idx % terrain_size.x, idx / terrain_size.x}
}

