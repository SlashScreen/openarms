package main

// Ad-hoc game code.

import "core:fmt"

DebugViews :: enum {
	PhysicsWorld,
}

// Which debug views are active right now
debug_views : bit_set[DebugViews] = {.PhysicsWorld}

game_init :: proc() {
	subscribe("key_event", NIL_USERDATA, game_key_input)
	subscribe("mouse_event", NIL_USERDATA, game_mouse_input)
}

game_key_input :: proc(_ : ^int, event : ^KeyEvent) {
	if event.key_action == .Pressed {
		#partial switch event.key {
		case .Space:
			fmt.println("Space pressed")
		}
	}
}

game_mouse_input :: proc(_ : ^int, event : ^MouseEvent) {
	if event.mouse_action == .Pressed {
		if event.button == .Left {
			cam := get_main_camera()
			forward := get_camera_forward(cam)
			fmt.printfln("Clicked. %v", forward)
			ray := get_screen_to_world_ray(event.position, cam^)
			res := query_ray(ray, 1000)
			if res != nil {
				fmt.printfln("Hit unit %v", res.(UnitID))
			}
		}
	}
}

