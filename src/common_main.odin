package main

common_init :: proc() {
	message_bus_create()
}

common_shutdown :: proc() {
	message_bus_destroy()
}

