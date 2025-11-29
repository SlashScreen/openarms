package client

import cm "../common"
import "core:fmt"

RuntimeArchetype :: struct {
	name:     string,
	mesh:     ResourceID,
	material: ResourceID,
}

// Not a slotmap because the server controls assignment of IDs
units: map[cm.UnitID]cm.Unit
archetypes: [dynamic]RuntimeArchetype

gs_init :: proc() {
	units = make(map[cm.UnitID]cm.Unit)
	archetypes = make([dynamic]RuntimeArchetype)

	mesh, _ := create_cube_mesh(cm.Vec3{1.5, 1.5, 1.5})
	material := create_material_default()
	set_material_albedo(material, missing_texture)
	//set_material_color(material, Color{1.0, 0.0, 0.0, 1.0})
	append(&archetypes, RuntimeArchetype{"test", mesh, material})
}

gs_deinit :: proc() {
	delete(units)
	delete(archetypes)
}

gs_create_unit :: proc(
	team: u8,
	unit_id: cm.UnitID,
	archetype: u32,
	transform: cm.Transform,
	target: cm.Vec2i,
) {
	u := cm.Unit{team, archetype, transform, target}
	units[unit_id] = u
}

gs_destroy_unit :: proc(unit_id: cm.UnitID) {
	delete_key(&units, unit_id)
}

// consumes data
gs_load_keyframe :: proc(data: []cm.KeyframeData) {
	defer delete(data)

	for ud in data {
		id := ud.unit_id
		u := ud.unit

		units[id] = u
	}
}

gs_tick :: proc() {
	for _, v in units {
		command: RenderCommand3D = DrawMesh{archetypes[v.archetype].mesh, archetypes[v.archetype].material, v.transform}
		cm.broadcast(
			"enqueue_3D",
			&command,
		)
	}
}
