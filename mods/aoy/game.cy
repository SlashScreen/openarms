-- WIP cyber port of the main game script

use game
use input
use physics
use sim
use render
use math

const CAM_ZOOM_SPEED f32 = 3.0
const CAM_MIN_DIST f32 = 10.0
const CAM_MAX_DIST f32 = 60.0
const CAM_MAX_DIST_MOVEMENT_MODIFIER f32 = 5.0
const CAM_SPRINT_MODIFIER f32 = 3.0

var selected ?UnitID = none
var cam_dist f32 = CAM_MIN_DIST
var camera_movement_speed f32 = 8.0
var camera_root_position math.Vector3 = math.Vector3.zero()

running := true

fn main():
	game.init()

	while running:
		events := game.gather_updates()
		for events |ev|:
			process_update(ev)

		delta := game.get_delta()
		game.update_simulation(delta)
		on_update(delta)

		game.draw()
		draw_hud()

		running = game.should_be_running()

	game.shutdown()


fn process_update(ev game.Event):
	switch ev.tag:
		case @input_event:
			on_input(ev.info as Ptr[InputEvent])


fn on_input(event Ptr[InputEvent]):
	switch event:
		case .key_event |ev|:
			switch ev.key_action:
				case .pressed:
					switch ev.key:
						case .space:
							print("Space pressed.")
		case .mouse_event |ev|:
			switch ev.mouse_action:
				case .pressed:
					switch ev.button:
						case .left:
							cam := render.main_camera()
							ray := cam.screen_to_world_ray(ev.position)
							selected_unit = physics.query_ray(ray, 1000.0)
						case .right:
							cam := render.main_camera()
							ray := cam.screen_to_world_ray(ev.position)
							if physics.query_ray_terrain(ray) |res|:
								print("hit terrain")
								if selected_unit |id|:
									info := game.UnitSetTargetInfo(id, res.point.xz)
									game.broadcast(game.SET_UNIT_TARGET_COMMAND, &info)


fn on_update(delta f32):
	mov := input.axis2(
		input.Range(input.binding(.camera_left), input.binding(.camera_right)),
		input.Range(input.binding(.camera_forward), input.binding(.camera_backward)),
	)
	cam := render.main_camera()
	cam_dist += (if (game.setting(.inverted_camera_scroll, bool)) input.scroll_movement() else -input.scroll_movement()) * CAM_ZOOM_SPEED
	cam_dist = math.clamp(cam_dist, CAM_MIN_DIST, CAM_MAX_DIST)

	cam_fac := math.remap(cam_dist, CAM_MIN_DIST, CAM_MAX_DIST, 0.0, 1.0)
	mov_3D := (
		math.Vector3(mov.x, 0.0, mov.y) *
		(camera_movement_speed * math.lerp(1.0, CAM_MAX_DIST_MOVEMENT_MODIFIER, cam_fac)) *
		(if (input.key_down(input.binding(.camera_sprint))) CAM_SPRINT_MODIFIER else 1.0) *
		delta
	)

	camera_root_position += mov_3D
	cam.position = camera_root_position + (-math.Vector3(0.0, -1.0, 1.0) * cam_dist)
	cam.target = camera_root_position


fn draw_hud():
	pass
