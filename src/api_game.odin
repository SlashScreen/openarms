#+private file
package main

import "base:runtime"
import cy "cyber"
import "vendor:raylib"

Event :: struct {
	tag :  i64,
	info : rawptr,
}

cy_init :: proc "c" (_ : ^cy.Thread) -> cy.Ret {
	context = runtime.default_context()
	client_init_subsystems()
	return .Ok
}

cy_gather_updates :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	return .Ok
}

cy_get_delta :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	ret := cy.get_ret(t, f32)
	ret^ = raylib.GetFrameTime()
	return .Ok
}

cy_update_simulation :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	context = runtime.default_context()
	dt := cy.thread_f32(t)
	client_tick_subsystems(dt)
	return .Ok
}

cy_draw :: proc "c" (_ : ^cy.Thread) -> cy.Ret {
	context = runtime.default_context()
	client_draw_subsystems()
	return .Ok
}

cy_should_be_running :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	ret := cy.get_ret(t, bool)
	ret^ = !raylib.WindowShouldClose()
	return .Ok
}

cy_shutdown :: proc "c" (_ : ^cy.Thread) -> cy.Ret {
	context = runtime.default_context()
	client_shutdown_subsystems()
	return .Ok
}

cy_setting :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	context = runtime.default_context()
	// TODO
	o := cy.get(t, Options)
	id := cy.get(t, i32)
	o_type, ok := cy.type_to_odin_type(cy.type_id_to_type(id^))
	//res := cy.get_ret(t, cy.ErrorUnion(o_type))
	if ok {
		//		o_value := options_settings[o^]
		//	res^ = cy.err_some(o_value, o_type)
	} else {
		//	res^ = cy.err_none(o_type)
	}
	return .Ok
}

FUNCS :: [?]struct {
	n : string,
	p : proc "c" (t : ^cy.Thread) -> cy.Ret,
} {
	{"init", cy_init},
	{"gather_updates", cy_gather_updates},
	{"get_delta", cy_get_delta},
	{"update_simulation", cy_update_simulation},
	{"draw", cy_draw},
	{"should_be_running", cy_should_be_running},
	{"shutdown", cy_shutdown},
	{"setting", cy_setting},
}

@(private)
load_game_api :: proc(vm : ^cy.VM, mod : ^cy.Sym, res : ^cy.LoaderResult) -> bool {
	for f in FUNCS {
		cy.mod_add_func(mod, cy.alias_string_to_bytes(f.n), cy.bind_func(f.p))
	}

	res.src = cy.alias_string_to_bytes(#load("api/game.cy", string))

	return true
}

