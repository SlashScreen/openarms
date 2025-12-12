package main

import "core:math"
// Ad-hoc game code.

import "core:fmt"
import "vendor:raylib"

CAM_MIN_DIST : f32 : 10.0
CAM_MAX_DIST : f32 : 60.0
CAM_MAX_DIST_MOVEMENT_MODIFIER : f32 : 5.0 // Speed boost for zoomed out movement
CAM_SPRINT_MODIFIER : f32 : 3.0
CAM_ZOOM_SPEED :: 3.0

DebugViews :: enum {
	PhysicsWorld,
	UI,
	StaticObstacles,
}

// Which debug views are active right now
debug_views : bit_set[DebugViews] = {.PhysicsWorld, .StaticObstacles}

camera_movement_speed : f32 = 8.0
camera_root_position : Vec3
cam_dist := CAM_MIN_DIST

selected_unit : Maybe(UnitID)

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
			ray := get_screen_to_world_ray(event.position, cam^)
			res, ok := query_ray(ray, 1000.0)
			if ok {
				log("Hit unit %v", res)
				selected_unit = res
				broadcast("selected_union", &selected_unit)
			} else {
				selected_unit = nil
				broadcast("deselected_union", NIL_MESSAGE)
			}
		case .Right:
			cam := get_main_camera()
			ray := get_screen_to_world_ray(event.position, cam^)
			res, ok := query_ray_terrain(ray)
			if ok {
				log("Hit terrain: %v", res.point)
				if id, ok := selected_unit.(UnitID); ok {
					info := UnitSetTargetInfo{id, res.point.xz}
					broadcast(SET_UNIT_TARGET_COMMAND, &info)
				}
			}
		}
	}
}

game_systems_tick :: proc(dt : f32) {
	mov := key_2_axis(
		{get_input_binding(.CameraLeft), get_input_binding(.CameraRight)},
		{get_input_binding(.CameraForward), get_input_binding(.CameraBackward)},
	)
	cam := get_main_camera()
	cam_dist +=
		(get_scroll_movement() if get_options_setting(.InvertedCameraScroll, bool) else -get_scroll_movement()) *
		CAM_ZOOM_SPEED
	cam_dist = clamp(cam_dist, CAM_MIN_DIST, CAM_MAX_DIST)

	cam_fac : f32 = math.remap(cam_dist, CAM_MIN_DIST, CAM_MAX_DIST, 0.0, 1.0)
	mov_3D :=
		Vec3{mov.x, 0.0, mov.y} *
		(camera_movement_speed * math.lerp(f32(1.0), CAM_MAX_DIST_MOVEMENT_MODIFIER, cam_fac)) *
		(CAM_SPRINT_MODIFIER if is_key_down(get_input_binding(.CameraSprint)) else f32(1.0)) *
		dt

	camera_root_position += mov_3D
	cam.position = camera_root_position + (-Vec3{0.0, -1.0, 1.0} * cam_dist)
	cam.target = camera_root_position
}

