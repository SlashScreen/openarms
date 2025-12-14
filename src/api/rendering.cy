use math
use physics

type Camera3D:
	position math.Vector3
	target math.Vector3
	up math.Vector3
	fovy f32
	projection CameraProjection

type CameraProjection enum:
	.perspective
	.orthagonal

#[bind="screen_to_world_ray"] (&Camera3D) screen_to_world_ray(pos : math.Vector2) -> physics.Ray

#[bind] main_camera() -> ^Camera3D
