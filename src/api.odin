package main

import "base:runtime"
import "cyber"

@(private = "file")
LOG_CYBER :: true

CyberLoadModuleFn :: proc(vm : ^cyber.VM, mod : ^cyber.Sym, res : ^cyber.LoaderResult) -> bool

vm : ^cyber.VM
cyber_modules : map[string]CyberLoadModuleFn

cyber_print_fn :: proc "c" (t : ^cyber.Thread, msg : cyber.Bytes) {
	context = runtime.default_context()
	log(cyber.bytes_to_string(msg))
}

cyber_print_err_fn :: proc "c" (t : ^cyber.Thread, msg : cyber.Bytes) {
	context = runtime.default_context()
	log_err(cyber.bytes_to_string(msg))
}

cyber_log_fn :: proc "c" (vm : ^cyber.VM, msg : cyber.Bytes) {
	when LOG_CYBER {
		context = runtime.default_context()
		log_debug(cyber.bytes_to_string(msg))
	}
}

cyber_global_log_fn :: proc "c" (msg : cyber.Bytes) {
	when LOG_CYBER {
		context = runtime.default_context()
		log_debug(cyber.bytes_to_string(msg))
	}
}

cyber_load_module :: proc "c" (
	vm : ^cyber.VM,
	mod : ^cyber.Sym,
	uri : cyber.Bytes,
	res : ^cyber.LoaderResult,
) -> bool {
	context = runtime.default_context()
	mod_name := cyber.clone_bytes_to_string(uri)
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
	cyber.vm_set_logger(vm, cyber_log_fn)
	cyber.set_global_log_fn(cyber_global_log_fn)
	if LOG_CYBER {cyber.set_verbose(true)}

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
	clstr := cyber.alias_bytes(src)
	res : cyber.EvalResult
	//log_debug("Evaluating script: %s", strings.unsafe_string_to_cstring(src))
	exit_code := cyber.vm_eval(
		vm,
		cyber.const_bytes("main"),
		clstr,
		cyber.EvalConfig{backend = .VM},
		&res,
	)

	switch exit_code {
	case .ErrorCompile:
		summary := cyber.vm_compile_error_summary(vm)
		defer cyber.vm_free(vm, summary)
		s := cyber.clone_bytes_to_string(summary)
		log_err("Cyber %s", s)
		return false, s
	case .ErrorPanic, .ErrorUnknown:
		summary := cyber.vm_error_summary(vm)
		defer cyber.vm_free(vm, summary)
		s := cyber.clone_bytes_to_string(summary)
		log_err("Cyber %s", s)
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
	res.src = src
	return true
}

load_core_api :: proc(vm : ^cyber.VM, mod : ^cyber.Sym, res : ^cyber.LoaderResult) -> bool {
	src := cyber.mod_bind_core(vm, mod)
	res.src = src
	return true
}

