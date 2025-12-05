package main

import "core:fmt"
import "core:strings"
import sm "slot_map"
import rl "vendor:raylib"

AssetID :: sm.Key(uint, 32, 32)

Image :: rl.Image

Asset :: union {
	Image,
}

asset_db : sm.DynamicSlotMap(Asset, AssetID)

asset_db_init :: proc() {
	asset_db = sm.dynamic_slot_map_make(Asset, AssetID)
}

asset_db_deinit :: proc() {
	sm.dynamic_slot_map_delete(&asset_db)
}

asset_db_load_image :: proc(path : string) -> (AssetID, bool) {
	if fp, ok := vfs_find(path); ok {
		img := rl.LoadImage(strings.unsafe_string_to_cstring(fp))
		id, iok := sm.dynamic_slot_map_insert_set(&asset_db, img)
		if !iok {
			fmt.eprintfln("problem loading image from %s into database. likely out of memory", fp)
			return AssetID{}, false
		}
		return id, true
	}

	return AssetID{}, false
}

asset_db_destroy :: proc(id : AssetID) {
	asset, ok := sm.dynamic_slot_map_get_ptr(&asset_db, id)
	if !ok do return

	switch a in asset {
	case Image:
		rl.UnloadImage(a)
	}
}

