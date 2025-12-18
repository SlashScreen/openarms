package libcyber

import "core:strings"
import i_ "internal"

// Odin wrapper for Cyber API.
// If you'd like to use the API directly, import "libcyber/internal".

// Cyber VM handle.
VM :: i_.VM
Thread :: i_.Thread
Heap :: i_.Heap
Value :: i_.Value

// Some API functions may require string slices rather than a null terminated string.
// NOTE: Returned `CLBytes`s are not always null terminated.
Bytes :: i_.Bytes
// Representation of a slice value within Cyber.
Slice :: i_.Slice
ValueSlice :: i_.ValueSlice
Str :: i_.CyberStr
// Representation of an option value within Cyber.
Option :: struct($T : typeid) {
	tag :     int,
	payload : T,
}
ErrorTag :: u64
// Representation of an error value within Cyber. Use the result of `error` for the error tag.
ErrorUnion :: struct($T : typeid) {
	tag :     ErrorTag,
	payload : T,
}

Unit :: i_.Unit
ExprResult :: i_.ExprResult
Node :: i_.Node
Sym :: i_.Sym
FuncSig :: i_.FuncSig
Func :: i_.Func

// Host function return value.
Ret :: i_.Ret
// Result code from executing a script.
ResultCode :: i_.ResultCode

NULL_ID :: i_.NULLID
TypeId :: i_.TypeId
Type :: i_.Type
TypeValue :: i_.TypeValue

HostFn :: proc "c" (_ : ^Thread) -> Ret

SemaFn :: i_.SemaFn
SemaFuncContext :: i_.SemaFuncContext

CtFuncContext :: i_.CtFuncContext
CtFn :: i_.CtFn
CtEvalFn :: i_.CtEvalFn

ResolverParams :: i_.ResolverParams
ResolverFn :: i_.ResolverFn
// Resolver function for dynamic libraries.
DlResolverFn :: i_.DlResolverFn

LoaderResult :: i_.LoaderResult
ModuleLoaderFn :: i_.ModuleLoaderFn
ModuleOnLoadFn :: i_.ModuleOnLoadFn
ModuleBindFn :: i_.ModuleBindFn
ModuleOnDestroyFn :: i_.ModuleOnDestroyFn

BindFuncKind :: i_.BindFuncKind
BindFunc :: i_.BindFunc
BindGlobal :: i_.BindGlobal
BindTypeKind :: i_.BindTypeKind

ResolveAliasFn :: i_.ResolveAliasFn

BindType :: i_.BindType

PrintFn :: i_.PrintFn
PrintErrorFn :: i_.PrintErrorFn
LogFn :: i_.LogFn
GlobalLogFn :: i_.GlobalLogFn

Allocator :: i_.Allocator

Backend :: i_.Backend
EvalConfig :: i_.EvalConfig
EvalResult :: i_.EvalResult

CompileConfig :: i_.CompileConfig
ValidateConfig :: i_.ValidateConfig

FieldInit :: i_.FieldInit
StackFrame :: i_.StackFrame
StackTrace :: i_.StackTrace

MemoryCheck :: i_.MemoryCheck
TraceInfo :: i_.TraceInfo

// VM functions

vm_init :: proc {
	i_.vm_init,
	i_.vm_initx,
	vm_init_all,
}

vm_init_all :: proc "c" (
	mod_loader : ModuleLoaderFn,
	printer : PrintFn,
	eprinter : PrintErrorFn,
	allocator : Allocator,
) -> ^VM {
	vm := i_.vm_initx(allocator)
	i_.vm_set_loader(vm, mod_loader)
	i_.vm_set_printer(vm, printer)
	i_.vm_set_eprinter(vm, eprinter)
	return vm
}

vm_deinit :: i_.vm_deinit

vm_get_allocator :: i_.vm_allocator
vm_get_main_thread :: i_.vm_main_thread

default_resolver :: i_.default_resolver
vm_get_resolver :: i_.vm_resolver
vm_set_resolver :: i_.vm_set_resolver
vm_set_dl_resolver :: i_.vm_set_dl_resolver
vm_resolve :: i_.vm_resolve

default_loader :: i_.default_loader
vm_get_loader :: i_.vm_get_loader
vm_set_loader :: i_.vm_set_loader

vm_get_printer :: i_.vm_printer
vm_set_printer :: i_.vm_set_printer
vm_get_eprinter :: i_.vm_eprinter
vm_set_eprinter :: i_.vm_set_eprinter
vm_set_logger :: i_.vm_set_logger

vm_reset :: i_.vm_reset

default_eval_config :: i_.DefaultEvalConfig
vm_eval :: proc {
	i_.vm_eval,
	i_.vm_evalx,
	i_.vm_eval_path,
}

default_compile_config :: i_.DefaultCompileConfig
vm_compile :: proc {
	i_.vm_compile,
	i_.vm_compile_path,
}

vm_validate :: i_.vm_validate

vm_error_summary :: i_.vm_error_summary
vm_compile_error_summary :: i_.vm_compile_error_summary

vm_alloc :: i_.vm_alloc
vm_alloc_bytes :: i_.vm_allocb

vm_free :: proc {
	i_.vm_free,
	i_.vm_freeb,
	i_.vm_freez,
}

vm_get_user_data :: i_.vm_user_data
vm_set_user_data :: i_.vm_set_user_data

vm_dump_bytecode :: i_.vm_dump_bytecode

// Module functions

mod_set_data :: i_.mod_set_data
mod_get_data :: i_.mod_get_data
mod_add_func :: i_.mod_add_func
mod_add_type :: i_.mod_add_type
mod_add_global :: i_.mod_add_global
mod_on_destroy :: i_.mod_on_destroy
mod_on_load :: i_.mod_on_load
mod_bind_core :: i_.mod_bind_core
mod_bind_cy :: i_.mod_bind_cy
mod_bind_c :: i_.mod_bind_c
mod_bind_io :: i_.mod_bind_io
mod_bind_meta :: i_.mod_bind_meta
mod_bind_math :: i_.mod_bind_math
mod_bind_test :: i_.mod_bind_test

// Thread functions

// Get return value for a function
thread_get_ret :: proc "contextless" (t : ^Thread, $T : typeid) -> ^T {
	return (^T)(i_.thread_ret(t, size_of(T)))
}

// Get a parameter value for a function
thread_get :: proc "contextless" (t : ^Thread, $T : typeid) -> ^T {
	return (^T)(i_.thread_ptr(t))
}

// Get a pointer parameter value for a function
thread_get_ptr :: i_.thread_ptr

// Get a primitive parameter value for a function
thread_get_prim :: proc "contextless" (t : ^Thread, $T : typeid) -> T {
	when T == i8 {
		return i_.thread_i8(t)
	} else when T == i16 {
		return i_.thread_i16(t)
	} else when T == i32 {
		return i_.thread_i32(t)
	} else when T == i64 {
		return i_.thread_int(t)
	} else when T == u8 {
		return i_.thread_byte(t)
	} else when T == u16 {
		return i_.thread_r16(t)
	} else when T == u32 {
		return i_.thread_r32(t)
	} else when T == u64 {
		return i_.thread_r64(t)
	} else when T == f32 {
		return i_.thread_f32(t)
	} else when T == f64 {
		return i_.thread_float(t)
	} else when T == Slice {
		return i_.thread_slice(t)
	} else when T == CyberStr {
		return i_.thread_str(t)
	} else when T == rawptr {
		return i_.thread_ptr(t)
	} else {
		#panic("Not a primitive type")
	}
}

// Gets the current global reference count.
// // NOTE: This will panic if the lib was not built with `Trace`.
// RELATED: `thread_count_objects()`
thread_global_reference_count :: i_.thread_rc
thread_count_objects :: i_.thread_count_objects
thread_dump_stats :: i_.thread_dump_stats
thread_dump_live_objects :: i_.thread_dump_live_objects

thread_signal_host_panic :: i_.thread_signal_host_panic
thread_signal_host_segfault :: i_.thread_signal_host_segfault

thread_trace_info :: i_.thread_trace_info
thread_check_memory :: i_.thread_check_memory

// Misc functions

find_type :: i_.find_type
value_desc :: i_.value_desc

create_error_value :: proc {
	create_error_value_from_bytes,
	create_error_value_from_string,
}
create_error_value_from_bytes :: proc "c" (vm : ^VM, b : Bytes) -> ErrorTag {
	return i_.error(vm, b)
}
create_error_value_from_string :: proc "c" (vm : ^VM, str : string) -> ErrorTag {
	return i_.error(vm, alias_bytes(str))
}

create_symbol :: proc {
	create_symbol_from_bytes,
	create_symbol_from_string,
}
create_symbol_from_bytes :: proc "c" (vm : ^VM, b : Bytes) -> i64 {
	return i_.symbol(vm, b)
}
create_symbol_from_string :: proc "c" (vm : ^VM, str : string) -> i64 {
	return i_.symbol(vm, alias_bytes(str))
}

// The reccommended way to initialize a Cyber string.
str_init :: i_.str_init
// Asserts ascii string and initializes a Cyber string.
astr_init :: i_.astr_init
// Asserts utf8 string and initializes a Cyber string.
ustr_init :: i_.ustr_init
str_deinit :: i_.str_deinit
// Conversion from value to a basic string description.
object_string :: i_.object_string

// Alias a string to a Bytes struct without copying.
// Host owns the string memory.
alias_bytes :: proc "contextless" (str : string) -> Bytes {
	return {raw_data(str), len(str)}
}

// Create a Bytes from a constant string.
// String memory is baked into the program ROM.
const_bytes :: proc "contextless" ($str : string) -> Bytes {
	return {raw_data(str), len(str)}
}

// Clones a Bytes into a string.
clone_bytes_to_string :: proc(b : Bytes) -> string {
	return strings.clone_from_cstring_bounded(cstring(b.ptr), int(b.len))
}

// Aliases a Bytes to a string without copying.
bytes_to_string :: proc(b : Bytes) -> string {
	return strings.string_from_ptr(b.ptr, int(b.len))
}

compare_string_to_bytes :: proc(str : string, bytes : Bytes) -> bool {
	return str == bytes_to_string(bytes)
}

slice_init :: i_.slice_init
func_union_init :: i_.new_func_union

lift :: i_.lift

array_empty_init :: i_.array_empty_new
map_empty_init :: i_.map_empty_new

bind_func :: proc(fn : HostFn) -> BindFunc {
	return {ptr = rawptr(fn), kind = .VM}
}

bind_global :: proc(ptr : rawptr) -> BindGlobal {
	return {ptr}
}

// Wrap an option value.
option_some :: proc($T : typeid, payload : T) -> Option(T) {
	return {tag = 1, payload = payload}
}

// Wrap an empty option value.
option_none :: proc($T : typeid) -> Option(T) {
	return {tag = 0}
}

// Wrap an error union with a value.
err_some :: proc($T : typeid, payload : T) -> ErrorUnion(T) {
	return {tag = 0, payload = payload}
}

// Wrap an error union with an error code.
err_err :: proc($T : typeid, error_code : i64) -> ErrorUnion(T) {
	return {tag = error_code}
}

type_id_to_type :: proc(n : i32) -> TypeId {
	if n > len(TypeId) || n < 0 do return .Null
	return (TypeId)(n)
}

type_to_odin_type :: proc(id : TypeId) -> (typeid, bool) #optional_ok {
	#partial switch id {
	case .Bool:
		return bool, true
	case .I8:
		return i8, true
	case .I16:
		return i16, true
	case .I32:
		return i32, true
	case .I64:
		return i64, true
	case .R8:
		return u8, true
	case .R16:
		return u16, true
	case .R32:
		return u32, true
	case .R64:
		return u64, true
	case .F32:
		return f32, true
	case .F64:
		return f64, true
	case .Symbol:
		return i64, true
	case .Str:
		return Str, true
	case .StrLit:
		return Bytes, true
	case:
		return u8, false
	}
}

