#+private file
package main

import "base:runtime"
import cy "cyber"

cy_binding :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	context = runtime.default_context()
	res := cy.thread_get_ret(t, Key)
	b := cy.thread_get(t, KeyActions)
	res^ = get_input_binding(b^)
	return .Ok
}

cy_axis2 :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	context = runtime.default_context()
	res := cy.thread_get_ret(t, [2]f32)
	x := cy.thread_get(t, InputRange)
	y := cy.thread_get(t, InputRange)
	res^ = key_2_axis(x^, y^)
	return .Ok
}

cy_key_down :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	context = runtime.default_context()
	res := cy.thread_get_ret(t, bool)
	b := cy.thread_get(t, Key)
	res^ = is_key_down(b^)
	return .Ok
}

cy_scroll_movement :: proc "c" (t : ^cy.Thread) -> cy.Ret {
	context = runtime.default_context()
	res := cy.thread_get_ret(t, f32)
	res^ = get_scroll_movement()
	return .Ok
}

FUNCS :: [?]struct {
	n : string,
	p : proc "c" (t : ^cy.Thread) -> cy.Ret,
} {
	{"binding", cy_binding},
	{"axis2", cy_axis2},
	{"key_down", cy_key_down},
	{"scroll_movement", cy_scroll_movement},
}

@(private)
load_input_api :: proc(vm : ^cy.VM, mod : ^cy.Sym, res : ^cy.LoaderResult) -> bool {
	for f in FUNCS {
		cy.mod_add_func(mod, cy.alias_bytes(f.n), cy.bind_func(f.p))
	}

	res.src = cy.const_bytes(#load("api/input.cy", string))

	return true
}

