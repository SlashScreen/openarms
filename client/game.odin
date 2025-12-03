package client

import cm "../common"
import "core:fmt"

game_init :: proc() {
	cm.subscribe("key_event", cm.NIL_USERDATA, game_key_input)
	cm.subscribe("mouse_event", cm.NIL_USERDATA, game_mouse_input)
}

game_key_input :: proc(_ : ^int, event : ^KeyEvent) {
	if event.key_action == .Pressed {
		#partial switch event.key {
		case .Space:
			fmt.println("Space pressed")
		}
	}
}

game_mouse_input :: proc(_ : ^int, event : ^MouseEvent) {
	if event.mouse_action == .Pressed {
		if event.button == .Left {
			cam := get_main_camera()
			forward := get_camera_forward(cam)
			fmt.printfln("Clicked. %v", forward)
		}
	}
}

