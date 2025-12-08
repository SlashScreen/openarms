package main

// Logging stuff

import "base:runtime"
import "core:c"
import "core:c/libc"
import "core:fmt"
import "core:terminal/ansi"
import rl "vendor:raylib"

@(private = "file")
FORCE_LOG :: !#config(SUPRESS_LOG, false)

LogLevels :: enum {
	Info,
	Debug,
	Warning,
	Error,
}

log_level : bit_set[LogLevels] = {.Info, .Debug, .Warning, .Error}

log :: proc(format : string, args : ..any) {
	when ODIN_DEBUG || FORCE_LOG {
		if !(.Info in log_level) do return

		str := fmt.aprintf(format, ..args)
		defer delete(str)

		fmt.eprintln("[INFO]:", str)
	}
}

log_debug :: proc(format : string, args : ..any) {
	when ODIN_DEBUG || FORCE_LOG {
		if !(.Debug in log_level) do return

		str := fmt.aprintf(format, ..args)
		defer delete(str)

		fmt.eprintln("[DEBUG]:", str)
	}
}

log_warn :: proc(format : string, args : ..any) {
	when ODIN_DEBUG || FORCE_LOG {
		if !(.Warning in log_level) do return

		str := fmt.aprintf(format, ..args)
		defer delete(str)

		fmt.printfln(
			ansi.CSI +
			ansi.FG_YELLOW +
			ansi.SGR +
			"[WARNING]: %s" +
			ansi.CSI +
			ansi.RESET +
			ansi.SGR,
			str,
		)
	}
}

log_err :: proc(format : string, args : ..any) {
	when ODIN_DEBUG || FORCE_LOG {
		if !(.Error in log_level) do return

		str := fmt.aprintf(format, ..args)
		defer delete(str)

		fmt.eprintln("[ERROR]:", str)
	}
}

rl_log_callback :: proc "c" (logLevel : rl.TraceLogLevel, text : cstring, args : ^c.va_list) {
	when ODIN_DEBUG || FORCE_LOG {
		context = runtime.default_context()
		buffer : [512]u8
		formatted_len := libc.vsprintf(raw_data(buffer[:]), text, args)

		#partial switch logLevel {
		case .INFO, .DEBUG:
			log(string(buffer[:formatted_len]))
		case .WARNING:
			log_warn(string(buffer[:formatted_len]))
		case .ERROR, .FATAL:
			log_err(string(buffer[:formatted_len]))
		case:
			return
		}
	}
}

