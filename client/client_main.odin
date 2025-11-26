package client

import rl "vendor:raylib"
import "../common"

client_init :: proc() {
    rl.InitWindow(800, 450, "Hellope!")
	rl.SetTargetFPS(60)
    net_init()
}

client_tick :: proc() {
    if rl.WindowShouldClose() {
        common.broadcast("shutdown", common.NIL_MESSAGE)
        return
    }
    rl.BeginDrawing()
    {
        rl.ClearBackground(rl.WHITE)
        rl.DrawText("hello", 150, 200, 20, rl.GRAY)
    }
    rl.EndDrawing()
}

client_shutdown :: proc() {
    rl.CloseWindow()
    net_shutdown()
}
