package client

import "../common"
import c "core:c"
import "core:fmt"
import rl "vendor:raylib"

WIDTH :: 800
HEIGHT :: 450

client_init :: proc() {
	rl.InitWindow(c.int(WIDTH), c.int(HEIGHT), "Hellope!")
	rl.SetTargetFPS(60)
	renderer_init(WIDTH, HEIGHT)
	gs_init()
	net_init()

	common.subscribe("render_texture_present", common.NIL_USERDATA, window_present)
}

client_tick :: proc() {
	if rl.WindowShouldClose() {
		common.broadcast("shutdown", common.NIL_MESSAGE)
		return
	}

	net_tick()
	gs_tick()

	draw()
}

client_shutdown :: proc() {
	rl.CloseWindow()
	net_shutdown()
	gs_deinit()
	renderer_deinit()
}

window_present :: proc(_ : ^int, tex : ^rl.RenderTexture2D) {
	rl.BeginDrawing()
	{
		rl.ClearBackground(rl.BLACK)
		rl.DrawTextureRec(
			tex.texture,
			rl.Rectangle{0.0, 0.0, f32(tex.texture.width), f32(-tex.texture.height)},
			rl.Vector2{0.0, 0.0},
			rl.WHITE,
		)
		rl.DrawText("hello", 150, 200, 20, rl.GRAY)
	}
	rl.EndDrawing()
}
