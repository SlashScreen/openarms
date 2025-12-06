package main

// Logging stuff

import "core:fmt"
import "core:terminal/ansi"

@(private)
SUPRESS_LOG :: !#config(NO_LOG, false)

log :: proc(format : string, args : ..any) {
	when ODIN_DEBUG || SUPRESS_LOG {
		str := fmt.aprintf(format, ..args)
		defer delete(str)

		fmt.eprintln("[INFO]: ", str)
	}
}

log_warn :: proc(format : string, args : ..any) {
	when ODIN_DEBUG || SUPRESS_LOG {
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
	when ODIN_DEBUG || SUPRESS_LOG {
		str := fmt.aprintf(format, ..args)
		defer delete(str)

		fmt.eprintln("[ERROR]: ", str)
	}
}

