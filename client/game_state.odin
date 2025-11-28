package client

import cm "../common"

// Not a slotmap because the server controls assignment of IDs
units: map[cm.UnitID]cm.Unit
archetypes_count := 1

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
