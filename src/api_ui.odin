package main

import "base:runtime"
import "cyber"

@(private = "file")
API_SRC :: `
#[bind] fn test_api()
`

load_ui_api :: proc(vm : ^cyber.VM, mod : ^cyber.Sym, res : ^cyber.LoaderResult) {
	log_debug("Loading UI API")
	cyber.mod_add_func(mod, cyber.alias_string_to_bytes("test_api"), cyber.bind_func(test_api))

	res.src = cyber.alias_string_to_bytes(API_SRC)
}

@(private = "file")
test_api :: proc "c" () {
	context = runtime.default_context()
	log("testing from UI API")
}

api_ui_init :: proc() {
	add_module_loader("ui", load_ui_api)
}

