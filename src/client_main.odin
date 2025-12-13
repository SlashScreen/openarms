package main

import c "core:c"
import "core:time"
import rl "vendor:raylib"

dt_tick : time.Tick
success := false

client_init :: proc() -> bool {
	rl.SetTraceLogCallback(rl_log_callback)
	rl.InitWindow(c.int(WIDTH), c.int(HEIGHT), "Hellope!")
	rl.SetTargetFPS(60)

	vfs_init()
	mount_mods()
	entry_point, ok := get_game_entry_point()
	if !ok {
		vfs_deinit()
		return false
	}

	log("Entry point at: %s", entry_point)
	api_init()
	code, c_ok := vfs_read_file(entry_point)
	if !c_ok {
		api_deinit()
		return false
	}
	api_run_script(code)

	return true
}

client_init_subsystems :: proc() {
	asset_db_init()

	message_bus_create()
	sim_init()

	renderer_init(WIDTH, HEIGHT)
	client_render_init()
	archetypes_init()

	game_init()
	navigation_init()
	hud_init()
	api_init()

	subscribe("render_texture_present", NIL_USERDATA, window_present)
}

client_tick :: proc() {
	if rl.WindowShouldClose() {
		broadcast("shutdown", NIL_MESSAGE)
		return
	}

	dt := f32(time.duration_seconds(time.tick_since(dt_tick)))
	dt_tick = time.tick_now()

	if !success {
		error_screen_draw(dt)
		return
	}
}

client_tick_subsystems :: proc(dt : f32) {
	poll_input()
	sim_tick(dt)
	game_systems_tick(dt)
}

client_draw_subsystems :: proc() {
	client_render_loop()
	navigation_draw()
	draw()
}

client_shutdown_subsystems :: proc() {
	rl.CloseWindow()

	api_deinit()
	hud_deinit()
	navigation_deinit()
	message_bus_destroy()
	client_render_deinit()
	archetypes_deinit()
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

