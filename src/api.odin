package main

import "base:runtime"
import "core:strings"
import "cyber"

CyberLoadModuleFn :: proc(vm : ^cyber.VM, mod : ^cyber.Sym, res : ^cyber.LoaderResult)

vm : ^cyber.VM
cyber_modules : map[string]CyberLoadModuleFn

cyber_print_fn :: proc "c" (t : ^cyber.Thread, msg : cyber.Bytes) {
	context = runtime.default_context()
	log(string(msg.ptr))
}

cyber_print_err_fn :: proc "c" (t : ^cyber.Thread, msg : cyber.Bytes) {
	context = runtime.default_context()
	log_err(string(msg.ptr))
}

cyber_load_module :: proc "c" (
	vm : ^cyber.VM,
	mod : ^cyber.Sym,
	uri : cyber.Bytes,
	res : ^cyber.LoaderResult,
) -> bool {
	context = runtime.default_context()
	for k, p in cyber_modules {
		if cyber.compare_string_to_bytes(k, uri) {
			p(vm, mod, res)
			return true
		}
	}
	return cyber.default_loader(vm, mod, uri, res)
}

add_module_loader :: proc(name : string, p : CyberLoadModuleFn) {
	cyber_modules[name] = p
}

api_init :: proc() {
	cyber_modules = make(map[string]CyberLoadModuleFn)
	vm = cyber.vm_init()
	cyber.vm_set_printer(vm, cyber_print_fn)
	cyber.vm_set_eprinter(vm, cyber_print_err_fn)
	cyber.vm_set_loader(vm, cyber_load_module)

	//api_ui_init()

	code := `

print('hello world')
`
	clstr := cyber.Bytes{strings.unsafe_string_to_cstring(code), len(code)}
	res : cyber.EvalResult
	exit_code := cyber.vm_eval(vm, clstr, &res)
	switch exit_code {
	case .ErrorCompile, .ErrorPanic, .ErrorUnknown:
		summary := cyber.vm_error_summary(vm)
		defer cyber.vm_freeb(vm, summary)
		log_err("Cyber Error: %s", summary)
	case .Success, .Await:
		log("Eval completed with code %v (%v)", exit_code, res)
	}
}

api_deinit :: proc() {
	cyber.vm_deinit(vm)
	delete(cyber_modules)
}

