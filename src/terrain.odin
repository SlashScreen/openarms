package main

import "core:fmt"
// Terrain for the game map.

import la "core:math/linalg"

TEST_HEIGHTMAP :: "test_heightmap.png"

terrain_mesh : ResourceID
terrain_tex : ResourceID
terrain_mat : ResourceID
terrain_model : ResourceID

terrain_init :: proc() {
	load_terrain(TEST_HEIGHTMAP, 2.0)
}

terrain_deinit :: proc() {
	unload_terrain()
}

load_terrain :: proc(fp : string, max_height : f32) {
	hmap, ok := asset_db_load_image(fp)
	if !ok {
		fmt.eprintln("failed to load image")
		return
	}
	defer asset_destroy(hmap)

	hmap_img := unwrap_asset_handle(hmap).(Image)
	terr, tok := create_heightmap_mesh(
		hmap,
		Vec3{f32(hmap_img.width), max_height, f32(hmap_img.height)},
	)
	if !tok {
		fmt.eprintln("failed to create mesh")
		return
	}

	terrain_mesh = terr

	tex_ok : bool
	terrain_tex, tex_ok = create_texture_from_image(hmap)
	if !tex_ok {
		fmt.eprintln("failed to create terrain texture")
		return
	}

	mat_ok : bool
	terrain_mat, mat_ok = create_material_default()
	if !mat_ok {
		fmt.eprintln("failed to load material")
		return
	}

	set_material_albedo(terrain_mat, terrain_tex)
	fmt.println("Loaded terrain")
}

unload_terrain :: proc() {
	resource_destroy(terrain_mesh)
	resource_destroy(terrain_mat)
	resource_destroy(terrain_tex)
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

