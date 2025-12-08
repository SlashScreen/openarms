package cyber

import "core:c"
foreign import libcyber "/windows/cyber.lib"

@(link_prefix = "CL", default_calling_convention = "c")
foreign libcyber {

}

TypeID :: c.uint32_t
Value :: c.uint64_t

VMCode :: enum {
	SUCCESS,
	AWAIT,
	ERROR_COMPILE,
	ERROR_PANIC,
	ERROR_UNKNOWN,
}

Type :: enum {
	NULL,
	VOID,
	BOOL,
	I8,
	I16,
	I32,
	I64,
	INT_LIT,
	R8,
	R16,
	R32,
	R64,
	F32,
	F64,
	ERROR,
	SYMBOL,
	OBJECT,
	ANY,
	TYPE,
	THREAD,
	CODE,
	FUNC_SIG,
	PARTIAL_STRUCT_LAYOUT,
	STR,
	STR_BUFFER,
	STR_LIT,
	NEVER,
	INFER,
	DEPENDENT,
	TCC_STATE,
	RANGE,
	TABLE,
	NO_COPY,
	MUT_STR,
}

TypeValue :: struct {
	type :  ^Type,
	value : Value,
}

