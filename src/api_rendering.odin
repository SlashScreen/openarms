package main

import cy "cyber"
import "vendor:raylib"

cy_screen_to_world_ray :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, Ray)
	cam : ^raylib.Camera3D = (^raylib.Camera3D)(cy.thread_ptr(t))
	vec := cy.get(t, Vec2)
	res^ = get_screen_to_world_ray(vec^, cam^)
	return .Ok
}

cy_main_camera :: proc(t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, ^raylib.Camera3D)
	res^ = get_main_camera()
	return .Ok
}

