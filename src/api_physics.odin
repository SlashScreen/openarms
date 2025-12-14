#+private file
package main

import "base:runtime"
import cy "cyber"

cy_query_ray :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	context = runtime.default_context()
	res := cy.get_ret(t, cy.Option(UnitID))
	ray := cy.get(t, Ray)
	max_dist := cy.thread_f32(t)

	id, ok := query_ray(ray^, max_dist)
	res^ = cy.option_some(UnitID, id) if ok else cy.option_none(UnitID)

	return .Ok
}

cy_query_ray_terrain :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	context = runtime.default_context()
	res := cy.get_ret(t, cy.Option(HitInfo))
	ray := cy.get(t, Ray)

	hit_res, ok := query_ray_terrain(ray^)
	res^ = cy.option_some(HitInfo, hit_res) if ok else cy.option_none(HitInfo)

	return .Ok
}

FUNCS :: [?]struct {
	n : string,
	p : proc "c" (t : ^cy.Thread) -> cy.Ret,
}{{"query_ray", cy_query_ray}, {"query_ray_terrain", cy_query_ray}}

@(private)
load_physics_api :: proc(vm : ^cy.VM, mod : ^cy.Sym, res : ^cy.LoaderResult) -> bool {
	for f in FUNCS {
		cy.mod_add_func(mod, cy.alias_string_to_bytes(f.n), cy.bind_func(f.p))
	}

	res.src = cy.alias_string_to_bytes(#load("api/physics.cy", string))

	return true
}

