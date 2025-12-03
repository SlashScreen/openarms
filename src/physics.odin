package main

import la "core:math/linalg"
import rl "vendor:raylib"

PhysicsShape :: union {
	BoundingBox,
	Sphere,
}

// Axis aligned bounding box
BoundingBox :: rl.BoundingBox

Sphere :: struct {
	position : Vec3,
	radius :   f32,
}

Ray :: rl.Ray

Plane :: struct {
	position : Vec3,
	normal :   Vec3,
}

FrustumPlanes :: enum {
	Top,
	Bottom,
	Left,
	Right,
	Near,
	Far,
}

Frustum :: struct {
	bounds : [FrustumPlanes]Plane,
}

HitInfo :: rl.RayCollision

ray_sphere_intersect :: proc(ray : Ray, sphere : Sphere) -> Maybe(HitInfo) {
	res := rl.GetRayCollisionSphere(ray, sphere.position, sphere.radius)
	if res.hit {
		return res
	} else {
		return nil
	}
}

ray_box_intersect :: proc(ray : Ray, box : BoundingBox) -> Maybe(HitInfo) {
	res := rl.GetRayCollisionBox(ray, box)
	if res.hit {
		return res
	} else {
		return nil
	}
}

sphere_box_intersect :: proc(sphere : Sphere, box : BoundingBox) -> bool {
	return rl.CheckCollisionBoxSphere(box, sphere.position, sphere.radius)
}

box_sphere_intersect :: sphere_box_intersect

box_box_intersect :: rl.CheckCollisionBoxes

plane_box_intersect :: proc(plane : Plane, box : BoundingBox) -> bool {
	// I will pretend to know how this works
	center := (box.max + box.min) * 0.5
	extents := (box.max - box.min) * 0.5

	// Box projection?...
	eff_radius :=
		extents.x * abs(plane.normal.x) +
		extents.y * abs(plane.normal.y) +
		extents.z * abs(plane.normal.z)

	// Signed distance
	d := la.dot(plane.normal, center - plane.position)

	return abs(d) <= eff_radius
}

BoxPlanePosition :: enum {
	Positive,
	Intersects,
	Negative,
}

// Which side of a plane does a box lie on
box_plane_position :: proc(box : BoundingBox, plane : Plane) -> BoxPlanePosition {
	// I will pretend to know how this works
	center := (box.max + box.min) * 0.5
	extents := (box.max - box.min) * 0.5

	// Box projection?...
	eff_radius :=
		extents.x * abs(plane.normal.x) +
		extents.y * abs(plane.normal.y) +
		extents.z * abs(plane.normal.z)

	// Signed distance
	d := la.dot(plane.normal, center - plane.position)

	switch {
	case d > eff_radius:
		return .Positive
	case d < -eff_radius:
		return .Negative
	case:
		return .Intersects
	}
}

BoxFrustumTest :: enum {
	Inside,
	TouchesSides,
	Outside,
}

box_inside_frustum :: proc(box : BoundingBox, frustum : Frustum) -> BoxFrustumTest {
	for p in frustum.bounds {
		test := box_plane_position(box, p)
		switch test {
		case .Negative:
			return .Outside
		case .Intersects:
			return .TouchesSides
		case .Positive:
			continue
		}
	}

	return .Inside
}

