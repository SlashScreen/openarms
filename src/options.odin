package main

// Options and input bindings

import "core:fmt"

KeyActions :: enum {
	CameraSprint,
	CameraForward,
	CameraBackward,
	CameraLeft,
	CameraRight,
}

input_map := [KeyActions]Key {
	.CameraSprint   = .L_Shift,
	.CameraForward  = .W,
	.CameraBackward = .S,
	.CameraLeft     = .A,
	.CameraRight    = .D,
}

get_input_binding :: proc(action : KeyActions) -> Key {
	return input_map[action]
}

Options :: enum {
	InvertedCameraScroll,
}

options_settings := [Options]any {
	.InvertedCameraScroll = true,
}

get_options_setting :: proc(option : Options, $T : typeid) -> T {
	if value, ok := options_settings[option].(T); ok {
		return value
	} else {
		fmt.panicf(
			"Attempted to unwrap an option setting into an improper type: expected %v, got %v",
			typeid_of(T),
			typeid_of(type_of(options_settings[option])),
		)
	}
}

