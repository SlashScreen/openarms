package client

import "../common"
import c "core:c"
import "core:time"
import rl "vendor:raylib"

WIDTH :: 800
HEIGHT :: 450

dt_tick : time.Tick

client_init :: proc() {
	rl.InitWindow(c.int(WIDTH), c.int(HEIGHT), "Hellope!")
	rl.SetTargetFPS(60)

	common.common_init()
	common.sim_init()

	renderer_init(WIDTH, HEIGHT)
	client_render_init()
	game_init()
	//gs_init()
	//net_init()

	common.subscribe("render_texture_present", common.NIL_USERDATA, window_present)

	dt_tick = time.tick_now()
}

client_tick :: proc() {
	if rl.WindowShouldClose() {
		common.broadcast("shutdown", common.NIL_MESSAGE)
		return
	}

	dt := f32(time.duration_seconds(time.tick_since(dt_tick)))
	dt_tick = time.tick_now()

	//net_tick()
	//gs_tick(dt)
	poll_input()
	common.sim_tick(dt)
	client_render_loop()

	draw()
}

client_shutdown :: proc() {
	rl.CloseWindow()
	//net_shutdown()
	//gs_deinit()
	client_render_deinit()
	common.sim_shutdown()
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

