package client

import cm "../common"
import "core:fmt"

game_init :: proc() {
	cm.subscribe("key_event", cm.NIL_USERDATA, game_key_input)
}

game_key_input :: proc(_ : ^int, event : ^KeyEvent) {
	if event.key_action == .Pressed {
		#partial switch event.key {
		case .Space:
			fmt.println("Space pressed")
		}
	}
}

