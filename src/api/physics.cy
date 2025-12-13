use math

-type Vector3 = math.Vector3

type Ray(position, direction Vector3)
type HitInfo:
	hit bool
	distance f32
	point Vector3
	normal Vector3

--| Query a ray into the world an return a possible hit unit.
#[bind] fn query_ray(ray Ray, max_dist f32) -> ?UnitID
--| Query a ray into the world against the terrain.
#[bind] fn query_ray_terrain(ray Ray) -> ?HitInfo
