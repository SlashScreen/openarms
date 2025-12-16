#+private file
package main

import cy "cyber"

FUNCS :: [?]struct {
	n : string,
	p : proc "c" (t : ^cy.Thread) -> cy.Ret,
}{}

@(private)
load_sim_api :: proc(vm : ^cy.VM, mod : ^cy.Sym, res : ^cy.LoaderResult) -> bool {
	for f in FUNCS {
		cy.mod_add_func(mod, cy.alias_string_to_bytes(f.n), cy.bind_func(f.p))
	}

	res.src = cy.alias_string_to_bytes(#load("api/sim.cy", string))

	return true
}

