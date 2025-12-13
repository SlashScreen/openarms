#+private file
package main

import cy "cyber"
import "vendor:raylib"

Event :: struct {
	tag :  i64,
	info : rawptr,
}

cy_init :: proc(_ : ^cy.Thread) -> cy.Ret {
	client_init_subsystems()
	return .Ok
}

cy_gather_updates :: proc(t : ^cy.Thread) -> cy.Ret {
	return .Ok
}

cy_get_delta :: proc(t : ^cy.Thread) -> cy.Ret {
	ret := cy.get_ret(t, f32)
	ret^ = raylib.GetFrameTime()
	return .Ok
}

cy_update_simulation :: proc(t : ^cy.Thread) -> cy.Ret {
	return .Ok
}

cy_draw :: proc(t : ^cy.Thread) -> cy.Ret {
	return .Ok
}

cy_should_be_running :: proc(t : ^cy.Thread) -> cy.Ret {
	ret := cy.get_ret(t, bool)
	ret^ = !raylib.WindowShouldClose()
	return .Ok
}

cy_shutdown :: proc(t : ^cy.Thread) -> cy.Ret {
	return .Ok
}

