package common

import rl "vendor:raylib"
import c "core:c"

GameMap :: struct {
	tiles:  []Tile,
	width:  uint,
	height: uint,
}

game_map_from_image :: proc (img : rl.Image) -> GameMap {
	g_map := GameMap {
		make([]Tile, img.width * img.height),
		uint(img.width),
		uint(img.height),
	}

	for y in 0..<g_map.height {
		for x in 0..<g_map.width {
			color := rl.GetImageColor(img, c.int(x), c.int(y))
			g_map.tiles[(y * g_map.width) + x] = Tile{f32(color.r)}
		}
	}

	return g_map
}

game_map_destroy :: proc(gm: ^GameMap) {
	delete(gm.tiles)
}
