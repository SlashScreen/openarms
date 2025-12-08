package main

// Separae from the renderer, reads from the game state and dispatches render calls.

import sm "slot_map"


client_render_init :: proc() {
	terrain_init()
}

client_render_deinit :: proc() {
	terrain_deinit()
}

client_render_loop :: proc() {
	for i in 0 ..< units.size {
		v := sm.dynamic_slot_map_get_ptr(&units, units.keys[i])
		command : RenderCommand3D = DrawMesh {
			archetypes[v.archetype].mesh,
			archetypes[v.archetype].material,
			v.transform,
			true,
		}
		broadcast(ENQUEUE_3D_COMMAND, &command)
	}

	terrain_draw()
}

