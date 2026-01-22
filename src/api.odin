#+private file
package main

import "umka"

UMPROF :: false
UMKA_TEST_CODE : cstring : `
fn main() {
    printf("Hello Umka!\n")
}
`
STACK_SIZE :: 1024 * 1024

@(private = "package")
api_init :: proc() {
	u := umka.Alloc()
	ok := umka.Init(
		u,
		"main.um",
		UMKA_TEST_CODE,
		STACK_SIZE,
		nil,
		0,
		nil,
		false,
		false,
		umka.PrintCompileWarning,
	)

	when UMPROF {
		if ok do umka.umprofInit(u)
	}

	if ok {
		ok = umka.Compile(u)
	}

	if ok {
		if umka.Run(u) != 0 {
			umka.PrintCompileError(u)
		}
	} else {
		umka.PrintCompileError(u)
	}


	when UMPROF {
		umka.umprofPrintTable()
		umka.umprofDinit()
	}

	umka.Free(u)
}

