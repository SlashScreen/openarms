package main

Module :: struct {
	ctx:    rawptr,
	init:   proc(self: rawptr),
	tick:   proc(self: rawptr, dt: f32),
	deinit: proc(self: rawptr),
}
