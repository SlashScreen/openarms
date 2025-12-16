use math
use meta
use input

type Options enum:
	case inverted_camera_scroll

type UnitSetTargetInfo(id UnitID, pos math.Vector2)

#[bind] -fn host_setting(o Option, )
fn setting(o Option, %T type) -> !T:
	return host_setting(o, meta.type.id(T))

-- Game loop

type EventPacket enum:
	case key input.KeyEvent
	case mouse input.MouseEvent

#[bind] fn init()
#[bind] fn gather_updates() -> []Event
#[bind] fn get_delta() -> f32
#[bind] fn update_simulation(dt f32)
#[bind] fn draw()
#[bind] fn should_be_running() -> bool
#[bind] fn shutdown()
