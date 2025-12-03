package main


import "core:fmt"
import sm "slot_map"

RuntimeArchetype :: struct {
	name :     string,
	mesh :     ResourceID,
	material : ResourceID,
}

archetypes : [dynamic]RuntimeArchetype
//render_loop_running := true
//render_loop : ^thread.Thread

client_render_init :: proc() {
	archetypes = make([dynamic]RuntimeArchetype)

	mesh, _ := create_cube_mesh(Vec3{1.5, 1.5, 1.5})
	material := create_material_default()
	if !set_material_albedo(material, missing_texture) do fmt.eprintln("Failed to set albedo")
	append(&archetypes, RuntimeArchetype{"test", mesh, material})

	//render_loop = thread.create_and_start(client_render_loop)
}

client_render_deinit :: proc() {
	delete(archetypes)

	//render_loop_running = false
	//thread.destroy(render_loop)
}

client_render_loop :: proc() {
	for i in 0 ..< units.size {
		v := sm.dynamic_slot_map_get_ptr(&units, units.keys[i])
		command : RenderCommand3D = DrawMesh {
			archetypes[v.archetype].mesh,
			archetypes[v.archetype].material,
			v.transform,
		}
		broadcast("enqueue_3D", &command)
	}
}

