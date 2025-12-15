#+private file
package main

import "base:runtime"
import cy "cyber"
import "vendor:raylib"

EventPacket :: union {
	KeyEvent,
	MouseEvent,
}

event_queue : [dynamic]EventPacket

// TODO: Figure out a way to do this that isn't so repetitive?

listen_key_input :: proc(_ : ^int, event : ^KeyEvent) {
	e : EventPacket = event^
	append(&event_queue, e)
}

listen_mouse_input :: proc(_ : ^int, event : ^MouseEvent) {
	e : EventPacket = event^
	append(&event_queue, e)
}

cy_init :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	context = runtime.default_context()
	// just init this stuff here
	event_queue = make([dynamic]EventPacket)
	client_init_subsystems()

	subscribe("key_event", NIL_USERDATA, listen_key_input)
	subscribe("mouse_event", NIL_USERDATA, listen_mouse_input)

	return .Ok
}

cy_gather_updates :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	res := cy.get_ret(t, cy.Slice)

	size := uint(len(event_queue) * size_of(EventPacket))
	slice := cy.Slice {
		ptr = raw_data(event_queue),
		len = size,
	}
	res^ = slice

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
	delete(event_queue)
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

