package main

import c "core:c"
import "core:time"
import rl "vendor:raylib"

dt_tick : time.Tick

client_init :: proc() {
	rl.SetTraceLogCallback(rl_log_callback)
	rl.InitWindow(c.int(WIDTH), c.int(HEIGHT), "Hellope!")
	rl.SetTargetFPS(60)

	vfs_init()
	asset_db_init()

	message_bus_create()
	sim_init()

	renderer_init(WIDTH, HEIGHT)
	client_render_init()
	game_init()
	hud_init()
	//gs_init()
	//net_init()

	subscribe("render_texture_present", NIL_USERDATA, window_present)

	dt_tick = time.tick_now()
}

client_tick :: proc() {
	if rl.WindowShouldClose() {
		broadcast("shutdown", NIL_MESSAGE)
		return
	}

	dt := f32(time.duration_seconds(time.tick_since(dt_tick)))
	dt_tick = time.tick_now()

	//net_tick()
	//gs_tick(dt)
	poll_input()
	sim_tick(dt)
	game_systems_tick(dt)
	client_render_loop()

	draw()
}

client_shutdown :: proc() {
	rl.CloseWindow()
	hud_deinit()
	message_bus_destroy()
	client_render_deinit()
	sim_shutdown()
	renderer_deinit()

	asset_db_deinit()
	vfs_deinit()
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
		hud_draw(rl.GetFrameTime())
	}
	rl.EndDrawing()
}

