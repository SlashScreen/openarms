package main

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

