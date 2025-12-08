package main

Archetype :: struct {
	name :       string,
	model_path : string,
	footprint :  Vec3,
	mesh :       ResourceID,
	material :   ResourceID,
	walk_speed : f32,
}

archetypes : [dynamic]Archetype

archetypes_init :: proc() {
	archetypes = make([dynamic]Archetype)

	load_archetype("test", "", Vec3{1.5, 1.5, 1.5})
}

load_archetype :: proc(name : string, path : string, footprint : Vec3) {
	mesh, _ := create_cube_mesh(footprint)
	material := create_material_default()
	if !set_material_albedo(material, missing_texture) do log_err("Failed to set albedo")

	archetype := Archetype{name, path, footprint, mesh, material, 5.0}

	append(&archetypes, archetype)
}

archetypes_deinit :: proc() {
	// Resource deinit will clean up meshes and textures etc
	delete(archetypes)
}

