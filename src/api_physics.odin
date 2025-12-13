#+private file
package main

import cy "cyber"

cy_query_ray :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, cy.Option(UnitID))
	ray := cy.get(t, Ray)
	max_dist := cy.thread_f32(t)

	id, ok := query_ray(ray^, max_dist)
	res^ = cy.option_some(UnitID, id) if ok else cy.option_none(UnitID)

	return .Ok
}

cy_query_ray_terrain :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, cy.Option(HitInfo))
	ray := cy.get(t, Ray)

	hit_res, ok := query_ray_terrain(ray^)
	res^ = cy.option_some(HitInfo, hit_res) if ok else cy.option_none(HitInfo)

	return .Ok
}

