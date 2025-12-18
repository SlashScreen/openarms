package internal

import "base:intrinsics"
import "core:c"
import "core:strings"

when ODIN_OS == .Windows {
	foreign import cyber "windows/cyber.lib"
} else when ODIN_OS == .Linux {
	foreign import cyber "linux/cyber.a"
} else when ODIN_OS == .Darwin {
	when ODIN_ARCH == .arm64 {
		foreign import cyber "macos-arm64/cyber.a"
	} else {
		foreign import cyber "macos/cyber.a"
	}
} else when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
	foreign import cyber "wasm/cyber.o"
}

VM :: struct {}
Thread :: struct {}
Heap :: struct {}
Value :: u64

Ret :: enum u8 {
	Ok,
	Interrupt,
}

ValueSlice :: struct {
	ptr : ^Value,
	len : c.size_t,
}

Unit :: struct {}
ExprResult :: struct {}
Node :: struct {}
FuncSig :: struct {}
Func :: struct {}
Sym :: struct {}

NULLID :: max(u32)

ResultCode :: enum i32 {
	Success,
	Await,
	ErrorCompile,
	ErrorPanic,
	ErrorUnknown,
}

TypeId :: enum i32 {
	Null,
	Void,
	Bool,
	I8,
	I16,
	I32,
	I64,
	IntLit,
	R8,
	R16,
	R32,
	R64,
	F32,
	F64,
	Error,
	Symbol,
	Object,
	Any,
	Type,
	Thread,
	Code,
	FuncSig,
	PartialStructLayout,
	Str,
	StrBuffer,
	StrLit,
	Never,
	Infer,
	Dependent,
	TccState,
	Range,
	Table,
	NoCopy,
	MutStr,
}

Type :: struct {}

TypeValue :: struct {
	type :  ^Type,
	value : Value,
}

// Some API functions may require string slices rather than a null terminated string.
// Creating a CLBytes can be simplified with a macro:
// #define bytes(x) ((CLBytes){ x, strlen(x) })
// NOTE: Returned `CLBytes`s are not always null terminated.
Bytes :: struct {
	ptr : [^]u8,
	len : c.size_t,
}

// Type layout of a Cyber `str` at runtime.
CyberStr :: struct {
	buf :    rawptr,
	ptr :    cstring,
	header : u64,
}

Slice :: struct {
	buf :    rawptr,
	ptr :    rawptr,
	len :    c.size_t,
	header : c.size_t,
}

// A host function is bound to a runtime function symbol declared with `#[bind]`.
HostFn :: proc "c" (t : ^Thread) -> Ret

SemaFuncContext :: struct {
	func :       ^Func,
	expr_start : c.size_t,
	node :       ^Node,
}

SemaFn :: proc "c" (unit : ^Unit, ctx : ^SemaFuncContext, res : ^ExprResult) -> bool

CtFuncContext :: struct {
	func : ^Func,
	args : ^Value,
	node : ^Node,
}

CtFn :: proc "c" (unit : ^Unit, ctx : ^CtFuncContext, res : ^ExprResult) -> bool
CtEvalFn :: proc "c" (unit : ^Unit, ctx : ^CtFuncContext) -> TypeValue

ResolverParams :: struct {
	/// Chunk that invoked the resolver.
	/// If `CL_NULLID`, then the invoker did not originate from another chunk module.
	chunkId : u32,

	/// The current URI.
	/// If it's the empty string, then the invoker did not originate from another chunk module.
	curUri :  Bytes,

	/// The unresolved URI.
	uri :     Bytes,

	// Buffer to write a dynamic the result to.
	buf :     cstring,
	bufLen :  c.size_t,
}

// Given the current module's resolved URI and the "to be" imported module specifier,
// set `params.resUri`, `params.resUriLen`, and return true.
// If the result uri is dynamic, write to `params.buf` to build the uri and set `params.resUri` to `params.buf`.
// If the result uri is a shared reference, `params.buf` does not need to be used.
// Return false if the uri can not be resolved.
// Most embedders do not need a resolver and can rely on the default resolver which
// simply returns `params.spec` without any adjustments.
ResolverFn :: proc "c" (vm : ^VM, params : ResolverParams, res_uri_len : ^c.size_t) -> bool
DlResolverFn :: proc "c" (vm : ^VM, uri : Bytes, out : ^Bytes) -> bool

// Callback invoked after all symbols in the module's src are loaded.
// This could be used to inject symbols not declared in the module's src.
ModuleOnLoadFn :: proc "c" (vm : ^VM, mod : ^Sym)

// Callback invoked just before the module is destroyed.
// This could be used to cleanup (eg. release) injected symbols from `CLPostLoadModuleFn`,
ModuleOnDestroyFn :: proc "c" (vm : ^VM, mod : ^Sym)

BindFuncKind :: enum i32 {
	VM   = 0,
	CT   = 1,
	SEMA = 2,

	// Compile the function with the declaration body.
	DECL = 3,
}

BindFunc :: struct {
	// CLHostFn or CLCtFn
	ptr :  rawptr,

	// CLCtEvalFn
	ptr2 : rawptr,
	kind : BindFuncKind,
}

BindGlobal :: struct {
	ptr : rawptr,
}

BindTypeKind :: enum i32 {
	// Use the provided declaration with a predefined or generated type id.
	DECL   = 0,
	CREATE = 1,
	ALIAS  = 2,
}

CreateTypeFn :: proc "c" (vm : ^VM, ctx_chunk : ^Sym, decl : ^Node) -> ^Type
ResolveAliasFn :: proc "c" (vm : ^VM, sym : ^Sym) -> ^Sym

// Result given to Cyber when binding a `#[bind]` type.
BindType :: struct {
	data : struct #raw_union {
		decl :   struct {
			// If `CL_NULLID`, a new type id is generated.
			type_id : TypeId,
		},
		create : struct {
			// Pointer to callback.
			create_fn : CreateTypeFn,
		},
		alias :  struct {
			// Pointer to callback.
			resolve_fn : ResolveAliasFn,
		},
	},

	// `CLBindTypeKind`.
	type : u8,
}

ModuleBindFn :: proc "c" (vm : ^VM, mod : ^Sym)

LoaderResult :: struct {
	src :        Bytes,

	// Whether `src` should be managed by the compiler (frees automatically). Defaults to false.
	manage_src : bool,
}

// Given the resolved import specifier of the module, return the module source code.
ModuleLoaderFn :: proc "c" (
	vm : ^VM,
	mod : ^Sym,
	resolved_uri : Bytes,
	res : ^LoaderResult,
) -> bool

// Handler for printing. The builtin `print` would invoke this.
// The default behavior is a no-op.
PrintFn :: proc "c" (t : ^Thread, CyberStr : Bytes)

// Handler for printing errors.
// The default behavior is a no-op.
PrintErrorFn :: proc "c" (t : ^Thread, CyberStr : Bytes)

// Handler for compiler logs as well as `core.log`.
// The default behavior is a no-op.
LogFn :: proc "c" (vm : ^VM, msg : Bytes)
GlobalLogFn :: proc "c" (msg : Bytes)

Backend :: enum i32 {
	VM   = 0,
	JIT  = 1,
	TCC  = 2,
	CC   = 3,
	LLVM = 4,
}

EvalConfig :: struct {
	/// Compiler options.
	single_run :         bool,
	gen_all_debug_syms : bool,
	backend :            Backend,
	spawn_exe :          bool,

	/// Persist main locals / use imports into the VM env. For REPL-like behavior.
	persist_main :       bool,
}

EvalResult :: struct {
	res :   ^Value,
	res_t : TypeId,
}

CompileConfig :: struct {
	/// Whether this process intends to perform eval once and exit.
	/// In that scenario, the compiler can skip generating the final release ops for the main block.
	single_run :         bool,
	skip_codegen :       bool,

	/// By default, debug syms are only generated for insts that can potentially fail.
	gen_all_debug_syms : bool,
	backend :            Backend,
	emit_source_map :    bool,

	/// Persist main locals / use imports into the VM env. For REPL-like behavior.
	persist_main :       bool,
}

ValidateConfig :: struct {}

Allocator :: struct {
	ptr :    rawptr,
	vtable : rawptr,
}

FieldInit :: struct {
	name :  Bytes,
	value : Value,
}

StackFrame :: struct {
	// Name identifier (e.g. function name, or "main")
	name :     Bytes,

	// Starts at 0.
	line :     u32,

	// Starts at 0.
	col :      u32,

	// Where the line starts in the source file.
	line_pos : u32,
	chunk :    u32,
}

StackTrace :: struct {
	frames :     ^StackFrame,
	frames_len : c.size_t,
}

@(default_calling_convention = "c", link_prefix = "cl")
foreign cyber {
	DefaultEvalConfig :: proc() -> EvalConfig ---
	DefaultCompileConfig :: proc() -> CompileConfig ---
	// Expand type template for given arguments.
	ExpandTypeTemplate :: proc(vm : ^VM, type_t : ^Sym, param_types : ^Type, args : ^Value, nargs : c.size_t) -> ^Type ---
	// Similar to `clFindType` and also resolves any missing template expansions.
	ResolveType :: proc(vm : ^VM, spec : Bytes) -> ^Type ---
	// Types.
	GetType :: proc(val : Value) -> ^Type ---
	GetFuncSig :: proc(vm : ^VM, params : ^Type, nparams : c.size_t, ret_t : ^Type) -> ^FuncSig ---
	ResultName :: proc(code : ResultCode) -> Bytes ---

	/// Some API callbacks use this to report errors.
	ReportApiError :: proc(vm : ^VM, msg : Bytes) ---
}

MemoryCheck :: struct {
	num_cyc_objects : u32,
}

TraceInfo :: struct {
	num_retains :  u32,
	num_releases : u32,
}

@(default_calling_convention = "c")
foreign cyber {
	clTypeId :: proc(type : ^Type) -> TypeId ---
}

@(default_calling_convention = "c", link_prefix = "cl_")
foreign cyber {
	// -----------------------------------
	// [ Top level ]
	// -----------------------------------
	full_version :: proc() -> Bytes ---
	version :: proc() -> Bytes ---
	build :: proc() -> Bytes ---
	commit :: proc() -> Bytes ---

	// Create a new VM with `mimalloc` as the allocator.
	vm_init :: proc() -> ^VM ---
	vm_initx :: proc(allocator : Allocator) -> ^VM ---

	// Deinitializes the VM and frees all memory associated with it. Any operation on `vm` afterwards is undefined.
	vm_deinit :: proc(vm : ^VM) ---
	vm_allocator :: proc(vm : ^VM) -> Allocator ---
	vm_main_thread :: proc(vm : ^VM) -> ^Thread ---
	vm_resolver :: proc(vm : ^VM) -> ResolverFn ---
	vm_set_resolver :: proc(vm : ^VM, resolver : ResolverFn) ---
	vm_resolve :: proc(vm : ^VM, uri : Bytes) -> Bytes ---

	// This is only relevant for binding dynamic libs.
	vm_set_dl_resolver :: proc(vm : ^VM, resolver : DlResolverFn) ---
	// The default module resolver. It returns `spec`.
	default_resolver :: proc(vm : ^VM, params : ResolverParams, res_uri_len : ^c.size_t) -> bool ---

	// The default module loader. It knows how to load the `builtins` module.
	default_loader :: proc(vm : ^VM, mod : ^Sym, resolved_uri : Bytes, res : ^LoaderResult) -> bool ---
	vm_get_loader :: proc(vm : ^VM) -> ModuleLoaderFn ---
	vm_set_loader :: proc(vm : ^VM, loader : ModuleLoaderFn) ---

	vm_printer :: proc(vm : ^VM) -> PrintFn ---
	vm_set_printer :: proc(vm : ^VM, print : PrintFn) ---
	vm_eprinter :: proc(vm : ^VM) -> PrintErrorFn ---
	vm_set_eprinter :: proc(vm : ^VM, print : PrintErrorFn) ---
	vm_set_logger :: proc(vm : ^VM, log : LogFn) ---

	// Resets the compiler and runtime state.
	vm_reset :: proc(vm : ^VM) ---

	// Evalutes the source code and returns the result code.
	// Subsequent evals will reuse the same compiler and runtime state.
	// If the last statement of the script is an expression, `res` will contain the value.
	vm_eval :: proc(vm : ^VM, src : Bytes, res : ^EvalResult) -> ResultCode ---

	// Accepts a `uri` and EvalConfig.
	vm_evalx :: proc(vm : ^VM, uri : Bytes, src : Bytes, config : EvalConfig, res : ^EvalResult) -> ResultCode ---

	// Uses a `uri` to load the source code.
	vm_eval_path :: proc(vm : ^VM, uri : Bytes, config : EvalConfig, res : ^EvalResult) -> ResultCode ---

	// Consumes and evaluates all ready tasks. Returns `CL_SUCCESS` if succesfully emptied the ready queue.
	// CLResultCode cl_run_ready_tasks(CLThread* t);
	vm_compile :: proc(vm : ^VM, uri : Bytes, src : Bytes, config : CompileConfig) -> ResultCode ---
	vm_compile_path :: proc(vm : ^VM, uri : Bytes, config : CompileConfig) -> ResultCode ---
	vm_validate :: proc(vm : ^VM, src : Bytes) -> ResultCode ---

	/// Convenience function to return the last error summary.
	/// Returns `cl_new_compile_error_summary` if the last result was a CL_ERROR_COMPILE,
	/// or `cl_thread_panic_summary` if the last result was a CL_ERROR_PANIC,
	/// or the null string.
	vm_error_summary :: proc(vm : ^VM) -> Bytes ---

	/// Returns first compile-time error summary. Must be freed with `cl_free`.
	vm_compile_error_summary :: proc(vm : ^VM) -> Bytes ---

	// For embedded, Cyber by default uses malloc (it can be configured to use the high-perf mimalloc).
	// If the host uses a different allocator than Cyber, use `clAlloc` to allocate memory
	// that is handed over to Cyber so it knows how to free it.
	// This is also used to manage accessible buffers when embedding WASM.
	// Only pointer is returned so wasm callsite can just receive the return value.
	vm_alloc :: proc(vm : ^VM, size : c.size_t) -> rawptr ---
	vm_allocb :: proc(vm : ^VM, size : c.size_t) -> Bytes ---

	// When using the Zig allocator, you'll need to pass the original memory size.
	// For all other allocators, use 1 for `len`.
	vm_free :: proc(vm : ^VM, ptr : rawptr, size : c.size_t) ---
	vm_freeb :: proc(vm : ^VM, bytes : Bytes) ---
	vm_freez :: proc(vm : ^VM, str : cstring) ---

	// Attach a userdata pointer inside the VM.
	vm_user_data :: proc(vm : ^VM) -> rawptr ---
	vm_set_user_data :: proc(vm : ^VM, data : rawptr) ---
	vm_dump_bytecode :: proc(vm : ^VM) ---

	// -----------------------------------
	// [ Threads ]
	// -----------------------------------
	thread_vm :: proc(t : ^Thread) -> ^VM ---
	thread_allocator :: proc(t : ^Thread) -> Allocator ---
	thread_panic_trace :: proc(t : ^Thread) -> StackTrace ---

	/// Returns runtime panic summary. Must be freed with `cl_free`.
	thread_panic_summary :: proc(t : ^Thread) -> Bytes ---

	/// Return value for the function. Prefer `get_ret`.
	thread_ret :: proc(t : ^Thread, size : c.size_t) -> rawptr ---
	thread_ret_panic :: proc(t : ^Thread, msg : Bytes) -> Ret ---
	/// Parameter for the function. Prefer `get`.
	thread_param :: proc(t : ^Thread, size : c.size_t) -> rawptr ---
	thread_str :: proc(t : ^Thread) -> CyberStr ---
	thread_ptr :: proc(t : ^Thread) -> rawptr ---
	thread_float :: proc(t : ^Thread) -> f64 ---
	thread_f32 :: proc(t : ^Thread) -> f32 ---
	thread_int :: proc(t : ^Thread) -> i64 ---
	thread_i32 :: proc(t : ^Thread) -> i32 ---
	thread_i16 :: proc(t : ^Thread) -> i16 ---
	thread_i8 :: proc(t : ^Thread) -> i8 ---
	thread_r64 :: proc(t : ^Thread) -> u64 ---
	thread_r32 :: proc(t : ^Thread) -> u32 ---
	thread_r16 :: proc(t : ^Thread) -> u16 ---
	thread_byte :: proc(t : ^Thread) -> u8 ---
	thread_slice :: proc(t : ^Thread) -> Slice ---
	thread_release :: proc(t : ^Thread, val : Value) ---
	thread_retain :: proc(t : ^Thread, val : Value) ---

	// Gets the current global reference count.
	// NOTE: This will panic if the lib was not built with `Trace`.
	// RELATED: `cl_thread_count_objects()`
	thread_rc :: proc(t : ^Thread) -> c.size_t ---

	// Logs eval stats about the thread.
	thread_dump_stats :: proc(t : ^Thread) ---

	// Returns the number of live objects.
	// This can be used to check if all objects were cleaned up after `clDeinit`.
	thread_count_objects :: proc(t : ^Thread) -> c.size_t ---

	// TRACE mode: Dump live objects recorded in global object map.
	thread_dump_live_objects :: proc(t : ^Thread) ---
	thread_signal_host_panic :: proc(t : ^Thread) ---
	thread_signal_host_segfault :: proc(t : ^Thread) ---
	thread_trace_info :: proc(t : ^Thread) -> TraceInfo ---

	// -----------------------------------
	// [ Modules ]
	// -----------------------------------
	mod_set_data :: proc(mod : ^Sym, data : rawptr) ---
	mod_get_data :: proc(mod : ^Sym) -> rawptr ---
	mod_add_func :: proc(mod : ^Sym, name : Bytes, binding : BindFunc) ---
	mod_add_type :: proc(mod : ^Sym, name : Bytes, binding : BindType) ---
	mod_add_global :: proc(mod : ^Sym, name : Bytes, binding : BindGlobal) ---
	mod_on_destroy :: proc(mod : ^Sym, on_destroy : ModuleOnDestroyFn) ---
	mod_on_load :: proc(mod : ^Sym, on_load : ModuleOnLoadFn) ---
	mod_bind_core :: proc(vm : ^VM, mod : ^Sym) -> Bytes ---
	mod_bind_cy :: proc(vm : ^VM, mod : ^Sym) -> Bytes ---
	mod_bind_c :: proc(vm : ^VM, mod : ^Sym) -> Bytes ---
	mod_bind_io :: proc(vm : ^VM, mod : ^Sym) -> Bytes ---
	mod_bind_meta :: proc(vm : ^VM, mod : ^Sym) -> Bytes ---
	mod_bind_math :: proc(vm : ^VM, mod : ^Sym) -> Bytes ---
	mod_bind_test :: proc(vm : ^VM, mod : ^Sym) -> Bytes ---

	// Find and return the type from a given type specifier.
	// Returns `NULL` if the symbol could not be found or the symbol is not a type.
	// Returns `NULL` if trying to resolve a template expansion that doesn't already exist.
	// NOTE: Currently this behaves like `clResolveType`.
	// If a type is returned, the type specifier is memoized to return the same result.
	find_type :: proc(vm : ^VM, spec : Bytes) -> ^Type ---

	// Returns a short description about a value given their type id.
	// Specializes for common types. Other types will only output the type id and the address.
	// This is very basic compared to the core API's `to_print_string` and `dump`.
	value_desc :: proc(vm : ^VM, val_t : TypeId, val : ^Value) -> Bytes ---

	// Error value. Use for a tag in an error union.
	error :: proc(vm : ^VM, str : Bytes) -> Value ---
	// Symbol value.
	symbol :: proc(vm : ^VM, str : Bytes) -> i64 ---

	// `cl_str` is the recommended way to initialize a new string.
	// `cl_astr` or `cl_ustr` asserts an ASCII or UTF-8 string respectively.
	str_init :: proc(t : ^Thread, str : Bytes) -> CyberStr ---
	astr_init :: proc(t : ^Thread, str : Bytes) -> CyberStr ---
	ustr_init :: proc(t : ^Thread, str : Bytes) -> CyberStr ---
	str_deinit :: proc(t : ^Thread, str : ^CyberStr) ---
	str_bytes :: proc(str : CyberStr) -> Bytes ---
	object_string :: proc(t : ^Thread, val : Value) -> Bytes --- // Conversion from value to a basic string description.

	// Initializes a new slice with undefined elements.
	slice_init :: proc(t : ^Thread, byte_buffer_t : TypeId, num_elems : c.size_t, elem_size : c.size_t) -> Slice ---

	// Functions.
	new_func_union :: proc(t : ^Thread, union_t : ^Type, func : HostFn) -> Value ---

	// Consumes and lifts a value (given as a pointer to the value) to the heap.
	lift :: proc(t : ^Thread, type : ^Type, value : rawptr) -> Value ---

	// Creates an empty array value.
	// Expects an array type `[]T` as `array_t` which can be obtained from `clExpandTypeTemplate` or `clResolveType`.
	array_empty_new :: proc(vm : ^VM, array_t : ^Type) -> Value ---
	map_empty_new :: proc(t : ^Thread, map_t : ^Type) -> Value ---
	// Check memory for reference cycles which indicates a bug in the program.
	thread_check_memory :: proc(t : ^Thread) -> MemoryCheck ---
}

