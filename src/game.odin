package main

import "vendor:raylib"
// Ad-hoc game code.

import "core:fmt"

DebugViews :: enum {
	PhysicsWorld,
}

// Which debug views are active right now
debug_views : bit_set[DebugViews] = {.PhysicsWorld}

camera_movement_speed : f32 = 8.0

@(private = "file")
camera_movement_vector : Vec2

game_init :: proc() {
	subscribe("key_event", NIL_USERDATA, game_key_input)
	subscribe("mouse_event", NIL_USERDATA, game_mouse_input)
}

game_key_input :: proc(_ : ^int, event : ^KeyEvent) {
	#partial switch event.key_action {
	case .Pressed:
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

game_systems_tick :: proc(dt : f32) {
	camera_movement_vector = key_2_axis({.A, .D}, {.S, .W})
	move_camera(get_main_camera(), camera_movement_vector * camera_movement_speed * dt)
}

move_camera :: proc(cam : ^raylib.Camera3D, movement : Vec2) {
	cam.position.x += movement.x
	cam.position.z += movement.y
}

