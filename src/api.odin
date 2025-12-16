package main

import "base:runtime"
import "core:strings"
import "cyber"

CyberLoadModuleFn :: proc(vm : ^cyber.VM, mod : ^cyber.Sym, res : ^cyber.LoaderResult) -> bool

vm : ^cyber.VM
cyber_modules : map[string]CyberLoadModuleFn
//sources : map[string]cyber.Bytes

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
	mod_name := strings.clone_from_cstring_bounded(uri.ptr, int(uri.len))
	log_debug("Loading cyber module: %s", mod_name)
	defer delete(mod_name)
	if p, ok := cyber_modules[mod_name]; ok {
		return p(vm, mod, res)
	}
	return false
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

	add_module_loader("core", load_core_api)
	add_module_loader("meta", load_meta_api)
	add_module_loader("game", load_game_api)
	add_module_loader("rendering", load_rendering_api)
	add_module_loader("physics", load_physics_api)
	add_module_loader("input", load_input_api)
	add_module_loader("sim", load_sim_api)
	add_module_loader("math", load_math_api)
}

api_run_script :: proc(src : string) -> (bool, string) {
	clstr := cyber.Bytes{strings.unsafe_string_to_cstring(src), len(src)}
	res : cyber.EvalResult
	//log_debug("Evaluating script: %s", strings.unsafe_string_to_cstring(src))
	exit_code := cyber.vm_eval(vm, clstr, &res)

	switch exit_code {
	case .ErrorCompile, .ErrorPanic, .ErrorUnknown:
		summary := cyber.vm_error_summary(vm)
		defer cyber.vm_freeb(vm, summary)
		s := strings.clone_from_cstring_bounded(summary.ptr, int(summary.len))
		log_err("Cyber Error: %s", s)
		return false, s
	case .Success, .Await:
		log("Eval completed with code %v (%v)", exit_code, res)
		return true, ""
	}
	return true, ""
}

api_deinit :: proc() {
	cyber.vm_deinit(vm)
	delete(cyber_modules)
}

load_meta_api :: proc(vm : ^cyber.VM, mod : ^cyber.Sym, res : ^cyber.LoaderResult) -> bool {
	src := cyber.mod_bind_meta(vm, mod)
	//sources["meta"] = cyber.mod_bind_meta(vm, mod)
	res.src = src
	return true
}

load_core_api :: proc(vm : ^cyber.VM, mod : ^cyber.Sym, res : ^cyber.LoaderResult) -> bool {
	log_debug("Loading core.")
	src := cyber.mod_bind_core(vm, mod)
	//sources["core"] = src
	res.src = src
	return true
}

