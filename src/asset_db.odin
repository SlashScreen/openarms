package main

import "core:c"
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
	for i in 0 ..< asset_db.size do asset_destroy(asset_db.keys[i])
	sm.dynamic_slot_map_delete(&asset_db)
}

unwrap_asset_handle :: proc(id : AssetID) -> (^Asset, bool) #optional_ok {
	return sm.dynamic_slot_map_get_ptr(&asset_db, id)
}

// Assets

asset_db_load_image :: proc {
	asset_db_load_image_from_filepath,
	asset_db_load_image_from_memory,
}

asset_db_load_image_from_filepath :: proc(path : string) -> (AssetID, bool) #optional_ok {
	if fp, ok := vfs_find(path); ok {
		img := rl.LoadImage(strings.unsafe_string_to_cstring(fp))
		id, iok := sm.dynamic_slot_map_insert_set(&asset_db, img)
		if !iok {
			fmt.eprintfln("problem loading image from %s into database. likely out of memory", fp)
			return AssetID{}, false
		}
		return id, true
	}

	fmt.eprintln("Failed to find image")
	return AssetID{}, false
}

asset_db_load_image_from_memory :: proc(
	extension : string,
	data : []u8,
) -> (
	AssetID,
	bool,
) #optional_ok {
	img := rl.LoadImageFromMemory(cstring(".png"), raw_data(data), c.int(len(data)))
	id, iok := sm.dynamic_slot_map_insert_set(&asset_db, img)
	if !iok {
		fmt.eprintln("problem loading image from memory into database. likely out of memory")
		return AssetID{}, false
	}
	return id, true
}

asset_destroy :: proc(id : AssetID) {
	asset, ok := sm.dynamic_slot_map_get_ptr(&asset_db, id)
	if !ok do return

	switch a in asset {
	case Image:
		rl.UnloadImage(a)
	}

	sm.dynamic_slot_map_remove(&asset_db, id)
}

