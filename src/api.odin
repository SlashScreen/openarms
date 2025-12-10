package main

import "base:runtime"
import "core:strings"
import "cyber"

vm : ^cyber.VM

cyber_print_fn :: proc "c" (t : ^cyber.Thread, msg : cyber.Bytes) {
	context = runtime.default_context()
	log(string(msg.ptr))
}

cyber_print_err_fn :: proc "c" (t : ^cyber.Thread, msg : cyber.Bytes) {
	context = runtime.default_context()
	log_err(string(msg.ptr))
}

api_init :: proc() {
	vm = cyber.vm_init()
	cyber.vm_set_printer(vm, cyber_print_fn)
	cyber.vm_set_eprinter(vm, cyber_print_err_fn)


	code := "print('hello world')"
	clstr := cyber.Bytes{strings.unsafe_string_to_cstring(code), len(code)}
	res : cyber.EvalResult
	exit_code := cyber.vm_eval(vm, clstr, &res)
	log("Eval completed with code %v (%v)", exit_code, res)
}

api_deinit :: proc() {
	cyber.vm_deinit(vm)
}

