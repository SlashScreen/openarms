#+private file
package main

import cy "cyber"

cy_query_ray :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, UnitID)
	ray := cy.get(t, Ray)
	max_dist := cy.thread_f32(t)

	id, ok := query_ray(ray^, max_dist)
	if ok {
		res^ = id
	}

	return .Ok
}

cy_query_ray_terrain :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, HitInfo)
	ray := cy.get(t, Ray)

	hit_res, ok := query_ray_terrain(ray^)
	if ok {
		res^ = hit_res
	}

	return .Ok
}

