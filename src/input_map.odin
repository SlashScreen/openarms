package main

Actions :: enum {
	CameraSprint,
	CameraForward,
	CameraBackward,
	CameraLeft,
	CameraRight,
}

input_map := [Actions]Key {
	.CameraSprint   = .L_Shift,
	.CameraForward  = .W,
	.CameraBackward = .S,
	.CameraLeft     = .A,
	.CameraRight    = .D,
}

get_input_binding :: proc(action : Actions) -> Key {
	return input_map[action]
}

