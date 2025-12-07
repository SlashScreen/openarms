package main

// Ad-hoc game code.

import "core:fmt"
import "vendor:raylib"

CAM_MIN_DIST : f32 : 10.0
CAM_MAX_DIST : f32 : 60.0
INVERTED_SCROLL :: false

DebugViews :: enum {
	PhysicsWorld,
}

// Which debug views are active right now
debug_views : bit_set[DebugViews] = {.PhysicsWorld}

camera_movement_speed : f32 = 8.0
camera_root_position : Vec3
cam_dist := CAM_MIN_DIST

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
		#partial switch event.button {
		case .Left:
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
	mov := key_2_axis({.A, .D}, {.W, .S})
	mov_3D := Vec3{mov.x, 0.0, mov.y} * camera_movement_speed * dt
	cam := get_main_camera()
	cam_dist += get_scroll_movement() if INVERTED_SCROLL else -get_scroll_movement()
	cam_dist = clamp(cam_dist, CAM_MIN_DIST, CAM_MAX_DIST)

	//raylib.UpdateCameraPro(cam, mov_3D, Vec3{0.0, 0.0, 1.0}, 45.0)
	camera_root_position += mov_3D
	cam.position = camera_root_position + (-Vec3{0.0, -1.0, 1.0} * cam_dist)
	cam.target = camera_root_position
}

