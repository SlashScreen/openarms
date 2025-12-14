#+private file
package main

import "base:runtime"
import cy "cyber"
import "vendor:raylib"

cy_screen_to_world_ray :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	context = runtime.default_context()
	res := cy.get_ret(t, Ray)
	cam : ^raylib.Camera3D = (^raylib.Camera3D)(cy.thread_ptr(t))
	vec := cy.get(t, Vec2)
	res^ = get_screen_to_world_ray(vec^, cam^)
	return .Ok
}

cy_main_camera :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	context = runtime.default_context()
	res := cy.get_ret(t, ^raylib.Camera3D)
	res^ = get_main_camera()
	return .Ok
}

FUNCS :: [?]struct {
	n : string,
	p : proc "c" (t : ^cy.Thread) -> cy.Ret,
}{{"screen_to_world_ray", cy_screen_to_world_ray}, {"main_camera", cy_main_camera}}

@(private)
load_rendering_api :: proc(vm : ^cy.VM, mod : ^cy.Sym, res : ^cy.LoaderResult) -> bool {
	for f in FUNCS {
		cy.mod_add_func(mod, cy.alias_string_to_bytes(f.n), cy.bind_func(f.p))
	}

	res.src = cy.alias_string_to_bytes(#load("api/rendering.cy", string))

	return true
}

