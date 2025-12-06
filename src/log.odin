package main

import "core:terminal/ansi"
// Logging stuff

import "core:fmt"

log :: proc(format : string, args : ..any) {
	str := fmt.aprintf(format, ..args)
	defer delete(str)

	fmt.eprintln("[INFO]: ", str)
}

log_warn :: proc(format : string, args : ..any) {
	str := fmt.aprintf(format, ..args)
	defer delete(str)

	fmt.printfln(ansi.FG_YELLOW + "[WARNING]: %s" + ansi.FG_DEFAULT, str)
}

log_err :: proc(format : string, args : ..any) {
	str := fmt.aprintf(format, ..args)
	defer delete(str)

	fmt.eprintln("[ERROR]: ", str)
}

