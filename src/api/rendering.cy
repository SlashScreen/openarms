use math
use physics

type Camera3D:
	position math.Vector3
	target math.Vector3
	up math.Vector3
	fovy f32
	projection CameraProjection

type CameraProjection enum:
	case perspective
	case orthagonal

#[bind="screen_to_world_ray"] fn screen_to_world_ray(cam ^Camera3D, pos math.Vector2) -> physics.Ray

#[bind] fn main_camera() -> ^Camera3D
