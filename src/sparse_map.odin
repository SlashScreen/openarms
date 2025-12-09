package main

// A sparse map used for data layers on top of the game world. Used primarily for navigation.

SparseMap :: struct($T : typeid) {
	values :        map[Vec2i]T,
	default_value : T,
}

sparse_map_get :: proc(
	sm : ^SparseMap($T),
	coords : Vec2i,
) -> (
	value : T,
	is_default : bool,
) #optional_ok {
	if val, ok := sm.values[coords]; ok {
		return val, true
	} else {
		return sm.default_value, false
	}
}

sparse_map_set :: proc(sm : ^SparseMap($T), coords : Vec2i, value : T) {
	if value != sm.default_value do sm.values[coords] = value
}

sparse_map_init :: proc($T : typeid, default_value : T) -> SparseMap(T) {
	return {make(map[Vec2i]T), default_value}
}

sparse_map_deinit :: proc(sm : ^SparseMap($T)) {
	delete(sm.values)
}

